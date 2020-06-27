using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using FBMVCExample.Models;

namespace FBMVCExample.Providers
{
    public class MyRoleProvider : RoleProvider
    {
        /// <summary>
        /// Возвращает список имён ролей у пользователя
        /// </summary>
        /// <param name="username">Имя пользователя</param>
        /// <returns></returns>
        public override string[] GetRolesForUser(string username)
        {
            string[] roles = new string[] { };
            using (DbModel db = new DbModel())
            {
                // Получаем пользователя
                WEBUSER user = db.WEBUSERS.FirstOrDefault(u => u.EMAIL == username);
                if (user != null)
                {
                    // заполняем массив доступных ролй
                    int i = 0;
                    roles = new string[user.WEBUSERINROLES.Count];
                    foreach (var rolesInUser in user.WEBUSERINROLES)
                    {
                        roles[i] = rolesInUser.WEBROLE.NAME;
                        i++;
                    }
                }
            }
            return roles;
        }

        /// <summary>
        /// Создаение новой роли
        /// </summary>
        /// <param name="roleName">Имя роли</param>
        public override void CreateRole(string roleName)
        {

            using (DbModel db = new DbModel())
            {
                WEBROLE newRole = new WEBROLE() { NAME = roleName };
                db.WEBROLES.Add(newRole);
                db.SaveChanges();
            }
        }

        /// <summary>
        /// Возвращает присутвует ли роль у пользователя
        /// </summary>
        /// <param name="username">Имя пользователя</param>
        /// <param name="roleName">Имя роли</param>
        /// <returns></returns>
        public override bool IsUserInRole(string username, string roleName)
        {
            bool outputResult = false;
            using (DbModel db = new DbModel())
            {
                var userInRole =
                    from ur in db.WEBUSERINROLES
                    where ur.WEBUSER.EMAIL == username && ur.WEBROLE.NAME == roleName
                    select new { id = ur.ID };

                outputResult = userInRole.Count() > 0;
            }
            return outputResult;
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get { throw new NotImplementedException(); }
            set { throw new NotImplementedException(); }
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            throw new NotImplementedException();
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }
    }
}