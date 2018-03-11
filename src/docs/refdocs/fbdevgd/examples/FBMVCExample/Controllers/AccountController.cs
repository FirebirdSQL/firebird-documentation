using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using FBMVCExample.Models;

namespace FBMVCExample.Controllers
{
    public class AccountController : Controller
    {
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(LoginModel model)
        {
            if (ModelState.IsValid)
            {
                // поиск пользователя в бд
                WEBUSER user = null;
                using (DbModel db = new DbModel())
                {
                    user = db.WEBUSERS.FirstOrDefault(u => u.EMAIL == model.Name && u.PASSWD == model.Password);

                }
                // если нашли пользователя с введённым логином и паролем, то 
                // запоминаем его и делаем переадресацию на стартовую страницу
                if (user != null)
                {
                    FormsAuthentication.SetAuthCookie(model.Name, true);
                    return RedirectToAction("Index", "Invoice");
                }
                else
                {
                    ModelState.AddModelError("", "Пользователя с таким логином и паролем не существует");
                }
            }

            return View(model);
        }

        [Authorize(Roles = "admin")]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(RegisterModel model)
        {
            if (ModelState.IsValid)
            {
                WEBUSER user = null;
                using (DbModel db = new DbModel())
                {
                    user = db.WEBUSERS.FirstOrDefault(u => u.EMAIL == model.Name);
                }
                if (user == null)
                {
                    // создаем нового пользователя
                    using (DbModel db = new DbModel())
                    {

                        // получаем новый идентификатор с помощью генератора
                        int userId = db.NextValueFor("SEQ_WEBUSER");
                        db.WEBUSERS.Add(new WEBUSER {
                            WEBUSER_ID = userId,
                            EMAIL = model.Name,
                            PASSWD = model.Password
                        });
                        db.SaveChanges();

                        user = db.WEBUSERS.Where(u => u.WEBUSER_ID == userId).FirstOrDefault();

                        // находим роль manager
                        // Эта роль будет ролью по умолчанию, т.е.
                        // будет выдана автоматически при регистрации
                        var defaultRole = db.WEBROLES.Where(r => r.NAME == "manager").FirstOrDefault();

                        // назначаем вновь добавленному пользователяю роль по умолчанию
                        if (user != null && defaultRole != null)
                        {
                            db.WEBUSERINROLES.Add(new WEBUSERINROLE
                            {
                                WEBUSER_ID = user.WEBUSER_ID,
                                WEBROLE_ID = defaultRole.WEBROLE_ID
                            });
                            db.SaveChanges();
                        }
                    }
                    // если пользователь удачно добавлен в бд
                    if (user != null)
                    {
                        FormsAuthentication.SetAuthCookie(model.Name, true);
                        return RedirectToAction("Login", "Account");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Пользователь с таким логином уже существует");
                }
            }

            return View(model);
        }

        public ActionResult Logoff()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login", "Account");
        }
    }
}