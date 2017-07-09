package codequalitychecker;

import java.awt.*;
import javax.swing.*;
import java.awt.datatransfer.*;
import java.awt.event.ActionEvent;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyListener;
import java.awt.event.MouseListener;

import java.util.*;
import java.io.*;



/**
 * <p>
 * Title: Java Frontend to Web Code Quality Checker</p>
 */
public class MainDialog extends JFrame {
    // UI
    JPanel panel1 = new JPanel();
    JButton templatesBtn = new JButton();
    JButton scanFilesBtn = new JButton();
    JButton examineFilesBtn = new JButton();
    JButton ForgetErrorBtn = new JButton();
    JButton ViewCodeBtn = new JButton();
    JButton ClearErrorsBtn = new JButton();
    JButton aboutBtn = new JButton();
    JButton optionsBtn = new JButton();
    JButton scanSignaturesBtn = new JButton();
    JButton countBtn = new JButton();
    JButton specialBtn = new JButton();
    JList files = null;
    JList errors = null;
    JLabel jLabel1 = new JLabel();
    JLabel jLabel2 = new JLabel();

    public MainDialog(String title) {
        this.setTitle(title);
        try {
            setDefaultCloseOperation(DISPOSE_ON_CLOSE);
            jbInit();
            pack();
        } catch (Exception exception) {
            exception.printStackTrace();
        }
    }

    public MainDialog() {
        this("Web Code Quality Checker");
    }

    private void jbInit() throws Exception {
        this.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        this.setResizable(false);

        DefaultListModel model1 = new DefaultListModel();
        files = new JList(model1);
        DefaultListModel model2 = new DefaultListModel();
        errors = new JList(model2);
        JScrollPane scrollPaneFiles = new JScrollPane(files);
        JScrollPane scrollPaneErrors = new JScrollPane(errors);

        errors.setTransferHandler(new FSTransfer(this));
        errors.setDragEnabled(false);

        panel1.setLayout(null);
        templatesBtn.setBounds(new Rectangle(8, 557, 107, 19));
        templatesBtn.setMargin(new Insets(0, 0, 0, 0));
        templatesBtn.setActionCommand("templatesBtn");
        templatesBtn.setText("<html>Scan for HTML</html>");
        templatesBtn.addActionListener(new Dialog1_templatesBtn_actionAdapter(this));
        templatesBtn.setBackground(new Color(215, 245, 229));
        scanFilesBtn.setBounds(new Rectangle(8, 538, 107, 19));
        scanFilesBtn.setMargin(new Insets(0, 0, 0, 0));
        scanFilesBtn.setActionCommand("scanFilesBtn");
        scanFilesBtn.setText("<html>Scan for code</html>");
        scanFilesBtn.addActionListener(new Dialog1_scanFilesBtn_actionAdapter(this));
        scanFilesBtn.setBackground(new Color(215, 245, 229));
        examineFilesBtn.setBounds(new Rectangle(194, 538, 78, 37));
        examineFilesBtn.setMargin(new Insets(0, 0, 0, 0));
        examineFilesBtn.setToolTipText("");
        examineFilesBtn.setActionCommand("examineFilesBtn");
        examineFilesBtn.setMnemonic('0');
        examineFilesBtn.setSelectedIcon(null);
        examineFilesBtn.setText("<html>Examine Selection</html>");
        examineFilesBtn.setBackground(new Color(215, 245, 229));
        examineFilesBtn.addActionListener(new Dialog1_examineFilesBtn_actionAdapter(this));
        ForgetErrorBtn.setBounds(new Rectangle(498, 538, 58, 37));
        ForgetErrorBtn.setMargin(new Insets(0, 0, 0, 0));
        ForgetErrorBtn.setActionCommand("ForgetErrorBtn");
        ForgetErrorBtn.setText("<html>Forget error</html>");
        ForgetErrorBtn.setBackground(new Color(248, 247, 198));
        ForgetErrorBtn.addActionListener(new Dialog1_ForgetErrorBtn_actionAdapter(this));
        ViewCodeBtn.setBounds(new Rectangle(404, 538, 89, 37));
        ViewCodeBtn.setMargin(new Insets(0, 0, 0, 0));
        ViewCodeBtn.setActionCommand("ViewCodeBtn");
        ViewCodeBtn.setText("<html>View code in editor</html>");
        ViewCodeBtn.addActionListener(new Dialog1_ViewCodeBtn_actionAdapter(this));
        ViewCodeBtn.setBackground(new Color(248, 247, 198));
        ClearErrorsBtn.setBounds(new Rectangle(560, 538, 75, 37));
        ClearErrorsBtn.setMargin(new Insets(0, 0, 0, 0));
        ClearErrorsBtn.setActionCommand("ClearErrorsBtn");
        ClearErrorsBtn.addActionListener(new Dialog1_ClearErrorsBtn_actionAdapter(this));
        ClearErrorsBtn.setText("<html>Clear error list</html>");
        aboutBtn.setBounds(new Rectangle(715, 538, 65, 37));
        aboutBtn.setMargin(new Insets(0, 0, 0, 0));
        aboutBtn.setActionCommand("aboutBtn");
        aboutBtn.setText("<html>About</html>");
        aboutBtn.addActionListener(new Dialog1_aboutBtn_actionAdapter(this));
        optionsBtn.setBounds(new Rectangle(639, 538, 72, 37));
        optionsBtn.setMargin(new Insets(0, 0, 0, 0));
        optionsBtn.setActionCommand("optionsBtn");
        optionsBtn.setText("<html>Options</html>");
        optionsBtn.addActionListener(new Dialog1_optionsBtn_actionAdapter(this));
        scanSignaturesBtn.setBounds(new Rectangle(277, 538, 122, 37));
        scanSignaturesBtn.setMargin(new Insets(0, 0, 0, 0));
        scanSignaturesBtn.setActionCommand("scanSignaturesBtn");
        scanSignaturesBtn.setText(
                "<html>Compile function signatures (PHP)</html>");
        scanSignaturesBtn.setBackground(new Color(215, 245, 229));
        scanSignaturesBtn.addActionListener(new Dialog1_scanSignaturesBtn_actionAdapter(this));
        countBtn.setBounds(new Rectangle(122, 538, 67, 37));
        countBtn.setMargin(new Insets(0, 0, 0, 0));
        countBtn.setActionCommand("countBtn");
        countBtn.setText("<html>Line Count</html>");
        countBtn.addActionListener(new Dialog1_countBtn_actionAdapter(this));
        countBtn.setBackground(new Color(215, 245, 229));
        specialBtn.setBounds(new Rectangle(560, 538, 75, 37));
        specialBtn.setMargin(new Insets(0, 0, 0, 0));
        specialBtn.setActionCommand("countBtn");
        specialBtn.setText("<html>Special tools</html>");
        specialBtn.addActionListener(new Dialog1_specialBtn_actionAdapter(this));
        specialBtn.setBackground(new Color(215, 245, 229));
        panel1.setMinimumSize(new Dimension(790, 590));
        files.setBackground(new Color(215, 245, 229));
        files.setSelectionMode(ListSelectionModel.MULTIPLE_INTERVAL_SELECTION);
        files.addKeyListener(new Dialog1_files_actionAdapterKey(this));
        files.addMouseListener(new Dialog1_files_actionAdapterClick(this));
        scrollPaneFiles.setBounds(new Rectangle(10, 14, 389, 517));
        errors.setBackground(new Color(248, 247, 198));
        errors.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        errors.addKeyListener(new Dialog1_errors_actionAdapterKey(this));
        errors.addMouseListener(new Dialog1_errors_actionAdapterClick(this));
        scrollPaneErrors.setBounds(new Rectangle(406, 14, 375, 517));
        jLabel1.setToolTipText("");
        jLabel1.setText(
                "<html>This is your project workspace. Set it by setting your code "
                + "directory in the options.</html>");
        jLabel1.setBounds(new Rectangle(26, 490, 339, 37));
        jLabel2.setText(
                "<html>Either double click a file from the left, click examine selected "
                + "files, or just drag and drop files here from your OS.<br>"
                + "<br>Any errors will show up in this pane, and you\'ll be able "
                + "to view the involved code in the chosen editor via a double-click.</html>");
        jLabel2.setBounds(new Rectangle(415, 380, 350, 130));
        panel1.add(aboutBtn);
        panel1.add(countBtn);
        panel1.add(specialBtn);
        panel1.add(examineFilesBtn);
        panel1.add(scanSignaturesBtn);
        panel1.add(ViewCodeBtn);
        panel1.add(ForgetErrorBtn);
        //panel1.add(ClearErrorsBtn);
        panel1.add(optionsBtn);
        panel1.add(scanFilesBtn);
        panel1.add(templatesBtn);
        panel1.add(jLabel1);
        panel1.add(scrollPaneFiles);
        panel1.add(jLabel2);
        panel1.add(scrollPaneErrors);
        this.getContentPane().add(panel1, java.awt.BorderLayout.WEST);
        panel1.setPreferredSize(new Dimension(790, 590));

        this.setVisible(true);

        // Loading of file list
        EventQueue.invokeLater(new Runnable() {
            public void run() {
                scanFilesBtn.doClick();
            }
        });
    }

    public void initiateFileSearch(String type) {
        boolean sort_new = false, skip_custom = false;

        String path = new String(Main.projectPath);
        if ((path.equals(".")) || (path.equals("./")) || (path.equals(".\\"))) {
            path = "";
        }

        int n = 0;
        n = JOptionPane.showOptionDialog(this, "Would you like to skip files underneath any directory with '*_custom' in the name?",
                "Question", JOptionPane.YES_NO_OPTION,
                JOptionPane.QUESTION_MESSAGE, null, null, null);
        if (n == JOptionPane.YES_OPTION) {
            skip_custom = true;
        }
        n = JOptionPane.showOptionDialog(this,
                "Would you like to sort by date?",
                "Question", JOptionPane.YES_NO_OPTION,
                JOptionPane.QUESTION_MESSAGE, null, null, null);
        if (n == JOptionPane.YES_OPTION) {
            sort_new = true;
        }

        ((DefaultListModel) this.files.getModel()).removeAllElements();

        ArrayList finalFiles = initiateFileSearch(type, path, "", skip_custom);
        if (sort_new) {
            Collections.sort(finalFiles);
        }

        Iterator it = finalFiles.iterator();
        while (it.hasNext()) {
            SearchFile next = (SearchFile) it.next();
            ((DefaultListModel) this.files.getModel()).addElement(next.path);
        }
    }

    public ArrayList initiateFileSearch(String type, String path, String rec_subpath,
            boolean skip_custom) {
        Date d = new Date();
        long currentTime = d.getTime() / 1000;
        ArrayList finalFiles = new ArrayList();

        File myFile = new File(path);
        String thefiles[] = myFile.list();
        if (thefiles == null) {
            return finalFiles;
        }
        Arrays.sort(thefiles);
        if (thefiles == null) {
            JOptionPane.showMessageDialog(this,
                    "Could not search the directory " + path + ".");
            return finalFiles;
        }
        int i;
        long last_m;
        File tmpFile;
        for (i = 0; i < thefiles.length; i++) {
            if (thefiles[i].equals(".")) {
                continue;
            }
            if (thefiles[i].equals("..")) {
                continue;
            }

            tmpFile = new File(path + File.separator + thefiles[i]);

            last_m = tmpFile.lastModified() / 1000 + 60 * 60 * 24;

            if (tmpFile.isDirectory()) {
                if ((skip_custom) && (thefiles[i].indexOf("_custom") != -1)) {
                    continue;
                }

                ArrayList next = initiateFileSearch(type, tmpFile.getAbsolutePath(),
                        rec_subpath + ((rec_subpath.equals("")) ? "" : File.separator)
                        + tmpFile.getName(), skip_custom);
                finalFiles.addAll(next);
            } else if (tmpFile.isFile()) {
                if ((type.equals("PHP")) && (!thefiles[i].toLowerCase().endsWith(".php"))) {
                    continue;
                }
                if ((type.equals("HTML"))
                        && (!thefiles[i].toLowerCase().endsWith(".html"))
                        && (!thefiles[i].toLowerCase().endsWith(".htm"))
                        && (!thefiles[i].toLowerCase().endsWith(".css"))
                        && (!thefiles[i].endsWith(".tpl"))
                        && (!thefiles[i].toLowerCase().endsWith(".ini"))) {
                    continue;
                }

                SearchFile mySearchFile = new SearchFile(rec_subpath
                        + ((rec_subpath.equals("")) ? "" : File.separator)
                        + tmpFile.getName(), tmpFile.lastModified());
                finalFiles.add(mySearchFile);
            }
        }

        return finalFiles;
    }

    public void aboutBtn_actionPerformed(ActionEvent e) {
        new AboutDialog().setVisible(true);
    }

    public void optionsBtn_actionPerformed(ActionEvent e) {
        new OptionsDialog().setVisible(true);
    }

    public void scanFilesBtn_actionPerformed(ActionEvent e) {
        initiateFileSearch("PHP");
    }

    public void scanSignaturesBtn_actionPerformed(ActionEvent e) {
        ((DefaultListModel) errors.getModel()).removeAllElements();
        executePHPfile("phpdoc_parser.php path=\"\"" + Main.projectPath + "\"");
    }

    public void templatesBtn_actionPerformed(ActionEvent e) {
        initiateFileSearch("HTML");
    }

    public void errors_actionPerformedKey(KeyEvent e) {
        if (e.getKeyChar() == '\n') {
            viewCodeLine();
        }
    }

    public void errors_actionPerformedMouse(MouseEvent e) {
        if ((e.getButton() == MouseEvent.BUTTON1) && (e.getClickCount() == 2)) {
            viewCodeLine();
        }
    }

    public void countBtn_actionPerformed(ActionEvent e) {
        int count = 0;
        int i;
        DefaultListModel listModel = (DefaultListModel) this.files.getModel();
        BufferedReader myReader;
        String line;
        for (i = 0; i < listModel.getSize(); i++) {
            if (!this.files.isSelectedIndex(i)) {
                continue;
            }

            try {
                myReader = new BufferedReader(new FileReader(Main.projectPath
                        + File.separator + (String) listModel.getElementAt(i)));
                line = myReader.readLine();
                while (line != null) {
                    if (!line.equals("")) {
                        count++;
                    }
                    line = myReader.readLine();
                }
            } catch (Exception e2) {
            } // No contribution to count
        }

        JOptionPane.showMessageDialog(this,
                "There are " + count + " lines of code in these files (discluding blank lines).");
    }

    public void specialBtn_actionPerformed(ActionEvent e) {
        JOptionPane.showMessageDialog(this,
                "Open up a web browser to the testing-tools directory, so the index.php loads and displays all available tools.");
    }

    private Vector decompose_line(String line) {
        Vector decomposed = new Vector();

        int i, num = 0;
        String current = "";
        boolean inquotes = false;
        String cchar;

        for (i = 0; i < line.length(); i++) {
            cchar = line.substring(i, i + 1);

            if (num == 4) {
                inquotes = true;
            }
            if ((cchar.equals("\"")) && (num < 4)) {
                inquotes = !inquotes;
            } else {
                if ((cchar.equals(" ")) && (!inquotes)) {
                    decomposed.addElement(current);
                    num++;
                    current = "";
                } else {
                    current = current + cchar;
                }
            }
        }
        decomposed.addElement(current);

        return decomposed;
    }

    private boolean line_skippable(String line) {
        Vector decomposed = decompose_line(line);
        Vector skip_decomposition = null;

        boolean same_0, same_1, same_3, same_4;
        int val_2_a, val_2_b;

        int i;
        for (i = 0; i < Main.skipped_errors.size(); i++) {
            skip_decomposition = decompose_line((String) Main.skipped_errors.get(i));

            if (decomposed.size() < 5) {
                continue;
            }

            same_0 = ((String) decomposed.get(0)).equals((String) skip_decomposition.get(0));
            same_1 = ((String) decomposed.get(1)).equals((String) skip_decomposition.get(1));
            same_3 = ((String) decomposed.get(3)).equals((String) skip_decomposition.get(3));
            same_4 = ((String) decomposed.get(4)).equals((String) skip_decomposition.get(4));
            try {
                val_2_a = Integer.parseInt((String) decomposed.get(2));
                val_2_b = Integer.parseInt((String) skip_decomposition.get(2));
                if ((same_0) && (same_1) && (val_2_a > val_2_b - 10)
                        && (val_2_a < val_2_b + 10) && (same_3) && (same_4)) {
                    return true;
                }
            } catch (NumberFormatException e) {
            }
        }

        return false;
    }

    public void files_actionPerformedKey(KeyEvent e) {
        if (e.getKeyChar() == '\n') {
            ((DefaultListModel) errors.getModel()).removeAllElements();
            Object sv[] = new Object[1];
            sv[0] = files.getSelectedValue();
            do_execution(sv);
        }
    }

    public void files_actionPerformedMouse(MouseEvent e) {
        if ((e.getButton() == MouseEvent.BUTTON1) && (e.getClickCount() == 2)) {
            ((DefaultListModel) errors.getModel()).removeAllElements();
            Object sv[] = new Object[1];
            sv[0] = files.getSelectedValue();
            do_execution(sv);
        }
    }

    public void files_actionPerformed(ActionEvent e) {
        ((DefaultListModel) errors.getModel()).removeAllElements();
        Object[] sv = (Object[]) this.files.getSelectedValues();
        do_execution(sv);
    }

    public void do_execution(Object[] sv) {
        do_execution(sv, false);
    }

    public void executePHPfile(String line) {
        Dialog tempProgress = new ProcessingDialog();
        tempProgress.setVisible(true);

        line = Main.phpPath + " " + line;
        System.out.println(line);
        try {
            Process execution = Runtime.getRuntime().exec(line);
            InputStream stream = execution.getInputStream();
            byte[] bytes = new byte[1024];
            String result = "";

            try {
                Thread.sleep(300);
            } catch (InterruptedException ex) {
            }

            int test = 0;
            while (test != -1) {
                test = stream.read(bytes);
                if (test != -1) {
                    result = result + new String(bytes, 0, test);
                }
            }
            String[] results = result.split("\n");
            int j;
            for (j = 0; j < results.length; j++) {
                if (!line_skippable(results[j])) {
                    ((DefaultListModel) errors.getModel()).addElement(results[j]);
                }
            }
            this.jLabel1.setVisible(false);
            this.jLabel2.setVisible(false);
        } catch (java.io.IOException e2) {
            JOptionPane.showMessageDialog(this,
                    "Failure executing PHP backend. ("
                    + e2.toString() + ")", "Error",
                    JOptionPane.ERROR_MESSAGE);
            tempProgress.setVisible(false);
            return;
        }

        tempProgress.setVisible(false);
    }

    public void do_execution(Object[] sv, boolean no_path) {
        int i, j;

        if (sv.length == 0) {
            JOptionPane.showMessageDialog(this, "No files were selected.",
                    "Error", JOptionPane.ERROR_MESSAGE);
        }
        String line = "code_quality.php spacedpaths=1";
        if (!no_path) {
            line = line + " path="
                    + Main.projectPath;
        } else {
            line = line + " path=\"\"";
        }
        for (i = 0; i < sv.length; i++) {
            line = line + " "
                    + ((String) sv[i]);
        }
        if (Main.relay__api) {
            line = line + " api=1";
        }
        if (Main.relay__checks) {
            line = line + " checks=1";
        }
        if (Main.relay__mixed) {
            line = line + " mixed=1";
        }
        if (Main.relay__non_terse) {
            line = line + " non_terse=1";
        }
        if (Main.relay__pedantic) {
            line = line + " pedantic=1";
        }
        if (Main.relay__security) {
            line = line + " security=1";
        }
        if (Main.relay__spelling) {
            line = line + " spelling=1";
        }

        executePHPfile(line);
    }

    private void viewCodeLine() {
        if (this.errors.getSelectedIndex() == -1) {
            JOptionPane.showMessageDialog(this, "No line was selected.");
            return;
        }

        String selected = (String) this.errors.getSelectedValue();

        Vector decomposed = decompose_line(selected);

        if ((decomposed.size() < 4)
                || ((!((String) decomposed.get(1)).endsWith(".php"))
                && (!((String) decomposed.get(1)).endsWith(".css"))
                && (!((String) decomposed.get(1)).endsWith(".js"))
                && (!((String) decomposed.get(1)).endsWith(".htm"))
                && (!((String) decomposed.get(1)).endsWith(".html"))
                && (!((String) decomposed.get(1)).endsWith(".tpl"))
                && (!((String) decomposed.get(1)).endsWith(".ini")))) {
            JOptionPane.showMessageDialog(this, "This line was not a code referencing line, so I cannot open up an editor there.");
            return;
        }

        String params = "";
        String line = "";
        if (Main.textEditorPath.toLowerCase().endsWith("ClPhpEd.exe")) {
            params = " /g" + decomposed.get(3) + ":" + decomposed.get(2);
            line = Main.textEditorPath + " \""
                    + (((((String) decomposed.get(1)).charAt(1) == ':')
                    || (((String) decomposed.get(1)).charAt(0) == '/')) ? ""
                            : Main.projectPath) + File.separator + decomposed.get(1) + "\"" + params;
        } else if (Main.textEditorPath.toLowerCase().endsWith("context.exe")) {
            params = " /g" + decomposed.get(3) + ":" + decomposed.get(2);
            line = Main.textEditorPath + " \""
                    + (((((String) decomposed.get(1)).charAt(1) == ':')
                    || (((String) decomposed.get(1)).charAt(0) == '/')) ? ""
                            : Main.projectPath) + File.separator + decomposed.get(1) + "\"" + params;
        } else if ((Main.textEditorPath.toLowerCase().endsWith("netbeans")) || (Main.textEditorPath.toLowerCase().endsWith("netbeans.exe"))) {
            line = Main.textEditorPath + " --open \""
                    + (((((String) decomposed.get(1)).charAt(1) == ':')
                    || (((String) decomposed.get(1)).charAt(0) == '/')) ? ""
                            : Main.projectPath) + File.separator + decomposed.get(1) + "\":" + decomposed.get(2);
        } else if (Main.textEditorPath.toLowerCase().endsWith("jedit.exe")) {
            params = " +line:" + decomposed.get(2);
            line = Main.textEditorPath + " \""
                    + (((((String) decomposed.get(1)).charAt(1) == ':')
                    || (((String) decomposed.get(1)).charAt(0) == '/')) ? ""
                            : Main.projectPath) + File.separator + decomposed.get(1) + "\"" + params;
        } else if (Main.textEditorPath.toLowerCase().endsWith("kate")) {
            params = " --line " + decomposed.get(2) + " --column "
                    + decomposed.get(3);
            line = Main.textEditorPath + " \""
                    + (((((String) decomposed.get(1)).charAt(1) == ':')
                    || (((String) decomposed.get(1)).charAt(0) == '/')) ? ""
                            : Main.projectPath) + File.separator + decomposed.get(1) + "\"" + params;
        } else if (Main.textEditorPath.toLowerCase().endsWith("mate")) {
            params = " -wl" + decomposed.get(2);
            line = Main.textEditorPath + " " + params + " "
                    + (((((String) decomposed.get(1)).charAt(1) == ':')
                    || (((String) decomposed.get(1)).charAt(0) == '/')) ? ""
                            : Main.projectPath) + File.separator + decomposed.get(1);
        } else {
            line = Main.textEditorPath + " \""
                    + (((((String) decomposed.get(1)).charAt(1) == ':')
                    || (((String) decomposed.get(1)).charAt(0) == '/')) ? ""
                            : Main.projectPath) + File.separator + decomposed.get(1) + "\"" + params;
        }

        if (this.errors.getSelectedIndex() == -1) {
            JOptionPane.showMessageDialog(this, "No file was selected.", "Error",
                    JOptionPane.ERROR_MESSAGE);
        }
        try {
            Runtime.getRuntime().exec(line);
        } catch (java.io.IOException e) {
            JOptionPane.showMessageDialog(this, "Failure executing text editor.",
                    "Error", JOptionPane.ERROR_MESSAGE);
            return;
        }
    }

    public void ViewCodeBtn_actionPerformed(ActionEvent e) {
        viewCodeLine();
    }

    public void ForgetErrorBtn_actionPerformed(ActionEvent e) {
        Main.skipped_errors.addElement(errors.getSelectedValue());
        DefaultListModel model = (DefaultListModel) errors.getModel();
        model.remove(errors.getSelectedIndex());
        String writePath = "non_errors.txt";

        // Save skipped
        try {
            FileWriter writer = new FileWriter(writePath);
            PrintWriter out = new PrintWriter(writer);
            int i;
            for (i = 0; i < Main.skipped_errors.size(); i++) {
                out.println((String) Main.skipped_errors.elementAt(i));
            }
            out.close();
        } catch (Exception e2) {
        } // No skip-saving then
    }
}

class Dialog1_errors_actionAdapterKey implements KeyListener {
    private MainDialog adaptee;

    Dialog1_errors_actionAdapterKey(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void keyTyped(KeyEvent e) {
        adaptee.errors_actionPerformedKey(e);
    }

    public void keyPressed(KeyEvent e) {
    }

    public void keyReleased(KeyEvent e) {
    }
}


class Dialog1_errors_actionAdapterClick implements MouseListener {
    private MainDialog adaptee;

    Dialog1_errors_actionAdapterClick(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void mouseClicked(MouseEvent e) {

        adaptee.errors_actionPerformedMouse(e);
    }

    public void mouseEntered(MouseEvent e) {
    }

    public void mouseExited(MouseEvent e) {
    }

    public void mousePressed(MouseEvent e) {
    }

    public void mouseReleased(MouseEvent e) {
    }
}


class Dialog1_files_actionAdapterKey implements KeyListener {
    private MainDialog adaptee;

    Dialog1_files_actionAdapterKey(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void keyTyped(KeyEvent e) {
        adaptee.files_actionPerformedKey(e);
    }

    public void keyPressed(KeyEvent e) {
    }

    public void keyReleased(KeyEvent e) {
    }
}


class Dialog1_files_actionAdapterClick implements MouseListener {
    private MainDialog adaptee;

    Dialog1_files_actionAdapterClick(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void mouseClicked(MouseEvent e) {

        adaptee.files_actionPerformedMouse(e);
    }

    public void mouseEntered(MouseEvent e) {
    }

    public void mouseExited(MouseEvent e) {
    }

    public void mousePressed(MouseEvent e) {
    }

    public void mouseReleased(MouseEvent e) {
    }
}


class Dialog1_ClearErrorsBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_ClearErrorsBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        ((DefaultListModel) adaptee.errors.getModel()).clear();
    }
}

class Dialog1_ForgetErrorBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_ForgetErrorBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.ForgetErrorBtn_actionPerformed(e);
    }
}

class Dialog1_files_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_files_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.files_actionPerformed(e);
    }
}


class Dialog1_ViewCodeBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_ViewCodeBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {

        adaptee.ViewCodeBtn_actionPerformed(e);
    }
}


class Dialog1_examineFilesBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_examineFilesBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {

        adaptee.files_actionPerformed(e);
    }
}


class Dialog1_countBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_countBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.countBtn_actionPerformed(e);
    }
}


class Dialog1_specialBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_specialBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.specialBtn_actionPerformed(e);
    }
}


class Dialog1_templatesBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_templatesBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.templatesBtn_actionPerformed(e);
    }
}


class Dialog1_scanSignaturesBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_scanSignaturesBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.scanSignaturesBtn_actionPerformed(e);
    }
}


class Dialog1_scanFilesBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_scanFilesBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.scanFilesBtn_actionPerformed(e);
    }
}


class Dialog1_optionsBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_optionsBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.optionsBtn_actionPerformed(e);
    }
}


class Dialog1_aboutBtn_actionAdapter implements ActionListener {
    private MainDialog adaptee;

    Dialog1_aboutBtn_actionAdapter(MainDialog adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.aboutBtn_actionPerformed(e);
    }
}


class FSTransfer extends TransferHandler {

    private MainDialog adaptee = null;

    public FSTransfer(MainDialog d) {
        this.adaptee = d;
    }

    public boolean importData(JComponent comp, Transferable t) {
        // Make sure we have the right starting points
        if (!t.isDataFlavorSupported(DataFlavor.javaFileListFlavor)) {
            return false;
        }

        // Grab the tree, its model and the root node
        try {
            java.util.List data = (java.util.List) t.getTransferData(DataFlavor.javaFileListFlavor);
            Object[] sl = data.toArray();
            if (adaptee != null) {
                String[] sl2 = new String[sl.length];
                int i;
                for (i = 0; i < sl.length; i++) {
                    sl2[i] = ((File) sl[i]).getAbsolutePath();
                }
                ((DefaultListModel) adaptee.errors.getModel()).
                        removeAllElements();
                adaptee.do_execution(sl2, true);
            }
            return true;
        } catch (UnsupportedFlavorException ufe) {
        } catch (IOException ioe) {
        }
        return false;
    }

    // We only support file lists on FSTrees...
    @Override
    public boolean canImport(JComponent comp, DataFlavor[] transferFlavors) {
        for (int i = 0; i < transferFlavors.length; i++) {
            if (!transferFlavors[i].equals(DataFlavor.javaFileListFlavor)) {
                return false;
            }
        }
        return true;
    }
}
