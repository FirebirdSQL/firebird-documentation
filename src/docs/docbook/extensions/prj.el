







(jde-set-project-name "xalan")
(jde-set-variables 
 '(jde-gen-session-bean-template (quote ("(jde-import-insert-imports-into-buffer (list \"javax.ejb.*\"
\"java.rmi.RemoteException\"))" "(jde-wiz-update-implements-clause \"SessionBean\")" "'> \"public void ejbActivate() throws RemoteException {\"'>'n \"}\"'>'n
'>'n" "'> \"public void ejbPassivate() throws RemoteException {\"'>'n \"}\"'>'n
'>'n" "'> \"public void ejbRemove() throws RemoteException {\"'>'n \"}\"'>'n '>'n" "'> \"public void setSessionContext(SessionContext ctx) throws
RemoteException {\"" "'>'n \"}\"'>'n '>'n" "'> \"public void unsetSessionContext() throws RemoteException {\"'>'n
\"}\"'>'n '>'n'>")))
 '(jde-gen-beep (quote ("(end-of-line) '&" "\"Toolkit.getDefaultToolkit().beep();\"'>'n'>")))
 '(jde-which-method-format (quote ("[" jde-which-method-current "]")))
 '(jde-run-classic-mode-vm nil)
 '(jde-javadoc-gen-nodeprecatedlist nil)
 '(jde-which-method-max-length 20)
 '(jde-imenu-include-classdef t)
 '(jde-javadoc-gen-link-online nil)
 '(jde-gen-code-templates (quote (("Get Set Pair" . jde-gen-get-set) ("toString method" . jde-gen-to-string-method) ("Action Listener" . jde-gen-action-listener) ("Window Listener" . jde-gen-window-listener) ("Mouse Listener" . jde-gen-mouse-listener) ("Mouse Motion Listener" . jde-gen-mouse-motion-listener) ("Inner Class" . jde-gen-inner-class) ("println" . jde-gen-println) ("beep" . jde-gen-beep) ("property change support" . jde-gen-property-change-support) ("EJB Entity Bean" . jde-gen-entity-bean) ("EJB Session Bean" . jde-gen-session-bean))))
 '(jde-gen-cflow-else (quote ("(if (jde-parse-comment-or-quoted-p)" "'(l \"else\")" "'(l '> \"else \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n'>'r'n" "\"} // end of else\"'>'n'>)" ")")))
 '(jde-make-args "")
 '(jde-javadoc-gen-destination-directory "JavaDoc")
 '(jde-mode-line-format (quote ("-" mode-line-mule-info mode-line-modified mode-line-frame-identification mode-line-buffer-identification "   " global-mode-string "   %[(" mode-name mode-line-process minor-mode-alist "%n" ")%]--" (line-number-mode "L%l--") (column-number-mode "C%c--") (-3 . "%p") (jde-which-method-mode ("--" jde-which-method-format "--")) "-%-")))
 '(jde-mode-abbreviations (quote (("ab" . "abstract") ("bo" . "boolean") ("br" . "break") ("by" . "byte") ("byv" . "byvalue") ("cas" . "cast") ("ca" . "catch") ("ch" . "char") ("cl" . "class") ("co" . "const") ("con" . "continue") ("de" . "default") ("dou" . "double") ("el" . "else") ("ex" . "extends") ("fa" . "false") ("fi" . "final") ("fin" . "finally") ("fl" . "float") ("fo" . "for") ("fu" . "future") ("ge" . "generic") ("go" . "goto") ("impl" . "implements") ("impo" . "import") ("ins" . "instanceof") ("in" . "int") ("inte" . "interface") ("lo" . "long") ("na" . "native") ("ne" . "new") ("nu" . "null") ("pa" . "package") ("pri" . "private") ("pro" . "protected") ("pu" . "public") ("re" . "return") ("sh" . "short") ("st" . "static") ("su" . "super") ("sw" . "switch") ("sy" . "synchronized") ("th" . "this") ("thr" . "throw") ("throw" . "throws") ("tra" . "transient") ("tr" . "true") ("vo" . "void") ("vol" . "volatile") ("wh" . "while"))))
 '(jde-imenu-enable t)
 '(jde-compile-option-verbose nil)
 '(jde-db-option-heap-size (quote ((1 . "megabytes") (16 . "megabytes"))))
 '(jde-bug-debugger-host-address "localhost" t)
 '(jde-make-working-directory "")
 '(jde-bug-breakpoint-marker-colors (quote ("red" . "yellow")))
 '(jde-javadoc-gen-use nil)
 '(jde-gen-buffer-boilerplate nil)
 '(jde-bug-raise-frame-p t)
 '(jde-db-option-application-args (quote ("-IN" "/share/xsl/docbook/test/exttest.xml" "-XSL " "/share/xsl/docbook/test/exttest.xsl")) t)
 '(jde-javadoc-gen-nonavbar nil)
 '(jde-javadoc-gen-nohelp nil)
 '(jde-bug-vm-includes-jpda-p nil)
 '(jde-gen-jfc-app-buffer-template (quote ("(funcall jde-gen-boilerplate-function) '>'n" "\"import java.awt.Dimension;\" '>'n" "\"import java.awt.Graphics;\" '>'n" "\"import java.awt.Graphics2D;\" '>'n" "\"import java.awt.Color;\" '>'n" "\"import java.awt.geom.Ellipse2D;\" '>'n" "\"import java.awt.event.WindowAdapter;\" '>'n" "\"import java.awt.event.WindowEvent;\" '>'n" "\"import javax.swing.JFrame;\" '>'n" "\"import javax.swing.JPanel;\" '>'n" "\"import javax.swing.JScrollPane;\" '>'n" "\"import javax.swing.JMenuBar;\" '>'n" "\"import javax.swing.JMenu;\" '>'n" "\"import java.awt.event.ActionEvent;\" '>'n" "\"import javax.swing.AbstractAction;\" '>'n '>'n" "\"/**\" '>'n" "\" * \"" "(file-name-nondirectory buffer-file-name) '>'n" "\" *\" '>'n" "\" *\" '>'n" "\" * Created: \" (current-time-string) '>'n" "\" *\" '>'n" "\" * @author <a href=\\\"mailto: \\\"\" (user-full-name) \"</a>\"'>'n" "\" * @version\" '>'n" "\" */\" '>'n" "'>'n" "\"public class \"" "(file-name-sans-extension (file-name-nondirectory buffer-file-name))" "\" extends JFrame\"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"class Canvas extends JPanel\"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"public Canvas () \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"setSize(getPreferredSize());\" '>'n" "\"Canvas.this.setBackground(Color.white);\" '>'n" "\"}\"'>'n '>'n" "\"public Dimension getPreferredSize() \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"return new Dimension(600, 600);\" '>'n" "\"}\"'>'n '>'n" "\"public void paintComponent(Graphics g) \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"super.paintComponent(g);\" '>'n" "\"Graphics2D g2d = (Graphics2D) g;\" '>'n" "\"Ellipse2D circle = new Ellipse2D.Double(0d, 0d, 100d, 100d);\" '>'n" "\"g2d.setColor(Color.red);\" '>'n" "\"g2d.translate(10, 10);\" '>'n" "\"g2d.draw(circle);\" '>'n" "\"g2d.fill(circle);\" '>'n" "\"}\"'>'n " "\"}\"'>'n '>'n" "\"public \"" "(file-name-sans-extension (file-name-nondirectory buffer-file-name))" "\"()\"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"super(\\\"\" (P \"Enter app title: \") \"\\\");\" '>'n" "\"setSize(300, 300);\" '>'n" "\"addWindowListener(new WindowAdapter() \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"public void windowClosing(WindowEvent e) {System.exit(0);}\" '>'n" "\"public void windowOpened(WindowEvent e) {}\" '>'n" "\"});\"'>'n" "\"setJMenuBar(createMenu());\" '>'n" "\"getContentPane().add(new JScrollPane(new Canvas()));\" '>'n" "\"}\"'>'n" "'>'n" "\"public static void main(String[] args) \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "'>'n" "(file-name-sans-extension (file-name-nondirectory buffer-file-name))" "\" f = new \"" "(file-name-sans-extension (file-name-nondirectory buffer-file-name))" "\"();\" '>'n" "\"f.show();\" '>'n" "\"}\"'>'n '>'n" "\"protected JMenuBar createMenu() \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"JMenuBar mb = new JMenuBar();\" '>'n" "\"JMenu menu = new JMenu(\\\"File\\\");\" '>'n" "\"menu.add(new AbstractAction(\\\"Exit\\\") \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"public void actionPerformed(ActionEvent e) \"" "(if jde-gen-k&r " "()" "'>'n)" "\"{\"'>'n" "\"System.exit(0);\" '>'n" "\"}\" '>'n" "\"});\" '>'n" "\"mb.add(menu);\" '>'n" "\"return mb;\" '>'n" "\"}\"'>'n " "\"} // \"'>" "(file-name-sans-extension (file-name-nondirectory buffer-file-name))" "'>'n")))
 '(jde-bug-key-bindings (quote (("[? ?