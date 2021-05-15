package uncc.project2;

/**
 * File: SWindow.java
 * ITIS 4440 User Interface Design and Implementation
 * See copyright at end of file
 * @author manuel a perez-quinones
 * @version 1.1
 *
 * Compile: javac SWindow.java
 * Javadoc: 
 javadoc -d javadoc SWindow.java SAction*.java \
    SShape.java SCircle.java SRectangle.java \
    STriangle.java \
     -windowtitle 'SFramework for ITIS4440 UNCC' \
     -doctitle 'SFramework for ITIS4440 UNCC' \
     -header '<b>ITIS4440</b>'
 */


import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.awt.Dimension;
import javax.swing.border.Border;
import javax.swing.event.MouseInputAdapter;

import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;
import java.util.ArrayList;
import java.util.function.Consumer;

import java.io.*;
import java.io.IOException;

/**
 * The SWindow class is the main class for the
 * SFramework. The SFramework is an object oriented
 * framework created to make graphical user interfaces
 * easy to build in a CS course. It is specifically
 * configured for ease of creating simple examples.
 * This class implements a reusable window that
 * includes a panel, some default menus, and provides 
 * a hook for a subclass to provide the drawing behavior.
 * It provides support for installing lambda expressions 
 * as actions for menu items.
*
* @author: manuel a perez-quinones
* @version 1.0
*/
public class SWindow extends MouseInputAdapter 
{
  private JFrame window;
  private JPanel canvas;
  private JMenuBar menuBar;
  private JMenu appMenu, fileMenu, editMenu;
  private JLabel status;
  private JMenuItem menuItem;

  private SDocument itsDocument = null;

  private HashMap<SActionKey, SActionState> actions;

  static protected ArrayList<SWindow> theWindowList = new ArrayList<SWindow>();
  static private int windowCount = 0;

  /**
   * Constructor, creates an SWindow. Does the work by 
   * calling the constructor with String/Boolean as
   * arguments using by default name "SWindow"
   */
  public SWindow() 
  {
    this("SWindow");
  }

  /**
   * Constructor, creates an SWindow. This is the
   * constructor that creates the window and connects
   * all the pieces for the SFramework.
   * @param appName - name of the app, used in menus and window titles
   */
  public SWindow(String appName) 
  {
    SWindow self = this;
    theWindowList.add(this);
    windowCount++;

    SwingUtilities.invokeLater(
      new Runnable() {
        public void run() {

          // with Lambda Expressions!
          actions = new HashMap<SActionKey, SActionState>();

          window = new JFrame(appName+"-"+windowCount);
          Container contentPane = window.getContentPane();
          contentPane.setLayout(new BorderLayout());

          //Create the menu bar.
          menuBar = new JMenuBar();

          //Build the app menu: About/Quit
          appMenu = new JMenu(appName);
          installMenuItem(appMenu, new JMenuItem("About"));
          appMenu.addSeparator();
          installMenuItem(appMenu, new JMenuItem("Quit"));
          menuBar.add(appMenu);

          //Build the File
          fileMenu = new JMenu("File");
          installMenuItem(fileMenu, new JMenuItem("New"));
          installMenuItem(fileMenu, new JMenuItem("Load"));
          installMenuItem(fileMenu, new JMenuItem("Save"));
          installMenuItem(fileMenu, new JMenuItem("Revert to saved"));
          fileMenu.addSeparator();
          installMenuItem(fileMenu, new JMenuItem("Close"));
          menuBar.add(fileMenu);

          editMenu = new JMenu("Edit");
          installMenuItem(editMenu, new JMenuItem("Undo"));
          editMenu.addSeparator();
          installMenuItem(editMenu, new JMenuItem("Cut"));
          installMenuItem(editMenu, new JMenuItem("Copy"));
          installMenuItem(editMenu, new JMenuItem("Paste"));
          menuBar.add(editMenu);


          // Drawing Canvas
          canvas = new JPanel() {
            protected void paintComponent(Graphics g) {
              paintCanvas((Graphics2D) g);
            }
          };
          canvas.setBorder(BorderFactory.createLineBorder(Color.BLUE, 1));

          // A bit of magic here to ensure that 
          // mouse actions are reported as:
          // press - drag - release
          // or
          // clicked
          MouseAdapter mouser = new MouseAdapter() {
            private Point startPt;
            private long startTime;
            private boolean reported = false;
            private boolean moved = false;
            public void mouseEntered(MouseEvent e)
            { self.mouseEntered(e); }
            public void mouseExited(MouseEvent e)
            { self.mouseEntered(e); }
            

            public void mousePressed(MouseEvent e)
            {
              reported = false;
              moved = false;
              startPt = e.getPoint();
              startTime = e.getWhen();
            }
            public void mouseDragged(MouseEvent e)
            {
              if (!moved) { // if we haven't moved yet
                if (!startPt.equals(e.getPoint())) {
                  // and the current point is not the same as
                  // the start point, the we have moved
                  moved = true;
                }
              }
              // else if (!startPt.equals(e.getPoint())) {
              //   moved = true;
              // }

              else { //if (moved)
                if (!reported) {
                  self.mousePressed(e);
                  reported = true;
                }
                self.mouseDragged(e);
              }
            }

            public void mouseReleased(MouseEvent e)
            {
              reported = true;
              // if the mouse moved
              if (moved) {
                self.mouseReleased(e);
              }
              else {
                self.mouseClicked(e); // pass it on
              }
            }
            public void mouseClicked(MouseEvent e)
            {
              if (!reported) {
                self.mouseClicked(e); // pass it on
                reported = true;
              }
            }
          };

          // Adding a local listener for mouse actions that
          // will call the SWindow methods
          canvas.addMouseListener(mouser);
          canvas.addMouseMotionListener(mouser);

          status = new JLabel("Status area");
          contentPane.add(canvas, BorderLayout.CENTER);
          contentPane.add(status, BorderLayout.SOUTH);

          window.setJMenuBar(menuBar);

          window.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
          window.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent e) {
              if (itsDocument != null)
                closeDocument();
              else
                closeWindow();
            }
          });
 
          // set the preferred size and the location and then
          // pack the window (force an internal layout)
          window.setPreferredSize(new Dimension(275, 300));
          int loc = 20 + (windowCount * 50);
          window.setLocation(loc, loc);
          window.pack();

          // Let a subclass do further configurations
          // like adding listeners
          init();

          // then show the window...
          window.setVisible(true);
          setStatus("Loaded");
        }
      }
    );
  }

  /**
   * Installs a menu item in the given menu. It adds
   * a default action that sets the status message with
   * the name of the menu item selected. The message lasts
   * for 2 seconds.
   * @param menu - JMenu where to install the item
   * @param item - JMenuItem to install at the end of the menu
   */
  public void installMenuItem(JMenu menu, JMenuItem item)
  {
    String menuName = menu.getText();
    String itemName = item.getText();
    installMenuItem(menu, item, ()-> {
      setStatus("Menu "+itemName, 2);
    });
  }

  /**
   * Installs a menu item (passed as string) in the given menu.
   * It create the JMenuItem needed and adds a default action 
   * that sets the status message with the name of the menu item 
   * selected. The message lasts for 2 seconds.
   * @param menu - JMenu where to install the item
   * @param itemName - name of the menu item to install at the end of the menu
   */
  public void installMenuItem(JMenu menu, String itemName)
  {
    JMenuItem item = new JMenuItem(itemName);
    String menuName = menu.getText();
    installMenuItem(menu, item, ()-> {
      setStatus("Menu "+itemName, 2);
    });
  }


  /**
   * Installs a menu item in the given menu with the
   * provided action.
   * @param menu - JMenu where to install the item
   * @param item - JMenuItem to install at the end of the menu
   * @param action - Action executed when menu item is selected
   */
  public void installMenuItem(JMenu menu, JMenuItem item, SAction action)
  {
    String menuName = menu.getText();
    String itemName = item.getText();

    menu.add(item);
    addAction(menuName, itemName, action);
    item.addActionListener((e) -> doAction(menuName, itemName));
  }


  /**
   * Installs a menu item (passed as string) in the given menu.
   * It create the JMenuItem needed and adds the action provided.
   * @param menu - JMenu where to install the item
   * @param itemName - name of the menu item to install at the end of the menu
   * @param action - Action executed when menu item is selected
   */
  public void installMenuItem(JMenu menu, String itemName, SAction action)
  {
    JMenuItem item = new JMenuItem(itemName);
    String menuName = menu.getText();

    menu.add(item);
    addAction(menuName, itemName, action);
    item.addActionListener((e) -> doAction(menuName, itemName));
  }


  /**
   * Init the window. This method allows for subclasses
   * to do further initalization once all parts have been 
   * created but before the window is made visible. The 
   * default method does nothing. The intention is to use
   * this method to add new menu items or add new actions
   * to existing menus and do further configuration of 
   * the window before it is displayed.
   */
  public void init() {}

  /**
   * Returns the JFrame used in this instance.
   * @return JFrame used by this instance.
   */
  public JFrame getWindow() { return window; }

  /**
   * Returns the title of the window. The title
   * is not stored locally, it is obtained from
   * the JFrame for this instance.
   * @return title of the window.
   */
  public String getTitle() { return window.getTitle(); }

  /**
   * Returns the JPanel used as the drawing canvas.
   * This canvas is where the paintCanvas() will
   * draw. 
   * @return JPanel that is used for drawing.
   */
  public JPanel getCanvas() { return canvas; }

  /**
   * Returns the JMenuBar installed in this window.
   * @return JMenuBar for this window.
   */
  public JMenuBar getMenuBar() { return menuBar; }

  /**
   * Returns the JMenu for the application menu
   * installed in this window.
   * @return JMenu for the application menu.
   */
  public JMenu getAppMenu() { return appMenu; }

  /**
   * Returns the JMenu for the file menu
   * installed in this window.
   * @return JMenu for the file menu.
   */
  public JMenu getFileMenu() { return fileMenu; }

  /**
   * Returns the JMenu for the edit menu
   * installed in this window.
   * @return JMenu for the edit menu.
   */
  public JMenu getEditMenu() { return editMenu; }

  /**
   * Returns the text in the status message area. Note
   * that the status can be set to clear after some seconds.
   * This returns whatever is displayed at the time of
   * the call; if it has been cleared, it returns an empty
   * string ("").
   * @return string with the message from the status area.
   */
  public String getStatus() { return status.getText(); }

  /**
   * Sets the message in the status area of this window.
   * @param message to be displayed in the status area
   */
  public void setStatus(String message)
  {
    // display message in status bar
    status.setText(message);
    status.repaint();
  }

  /**
   * Sets the message in the status bar of this window
   * and after specified seconds, clears it.
   * @param message to be displayed in the status area
   * @param seconds after which the status is cleared
   */
  public void setStatus(String message, int seconds)
  {
    setStatus(message, seconds, null);
  }

  /**
   * Sets the message in the status bar of this window
   * and after specified seconds, sets another message
   * that will stay until another setStatus call changes it.
   * @param message to be displayed in the status area
   * @param seconds after which the status is changed
   * @param toMessage change status to this message. If null
   * the message is cleared
   */
  public void setStatus(String message, int seconds, String toMessage)
  {
    setStatus(message);

    Timer timer = new Timer();
    timer.schedule(new TimerTask() {
        public void run() {
            if (toMessage == null)
              clearStatus();  // clear the message
            else
              setStatus(toMessage);
            timer.cancel(); // Terminate the timer thread
        }
      }, seconds*1000);
  }

  /**
   * Clears the message in the status bar of this window
   */
  public void clearStatus()
  {
    setStatus("");
  }

  /**
   * This method attaches an SDocument to this SWindow,
   * providing file open/save support.
   * @param doc - SDocument implementation that does the read/write
   */
  public void attachDocument(SDocument doc)
  {
    itsDocument = doc;
    addAction("File", "Load", this::loadDocument);
    addAction("File", "Save", this::saveDocument);
    addAction("File", "Close", this::closeDocument);
    addAction("File", "Revert to saved", this::revertDocument);
    if (itsDocument.hasFile())
      this.enableAction("File", "Revert to saved");
    else
      this.disableAction("File", "Revert to saved");
  }

  /**
   * Marks this document as modified (dirty). This flag is used
   * to decide if a "Do you want to save" question is displayed
   * when the document is being closed.
   */
  public void markDirty() {
    itsDocument.markDirty();
    this.enableAction("File", "Save");
    if (itsDocument.hasFile())
      this.enableAction("File", "Revert to saved");
    else
      this.disableAction("File", "Revert to saved");
  }

  /**
   * Marks this document clean, there are not changes to save.
   */
  public void markClean() {
    itsDocument.markClean();
    this.disableAction("File", "Save");
    this.disableAction("File", "Revert to saved");
  }

  /**
   * UI implementation of a load document command. The load
   * command is defined as reading a data file and replacing
   * the contents of the document. This implementation does
   * the following. 1) checks if the document has data and
   * hasn't been saved; if so, prompts the user to save it first.
   * 2) then prompts the use to select a file to load.
   * 3) read the data (via delegation to an SDocument object)
   */
  public void loadDocument()
  {
    if (itsDocument != null) {
      // has a document, then check if is has been modified
      if (itsDocument.isDirty()) {
        // has been modified...
        int response = JOptionPane.showConfirmDialog(this.getWindow(), 
          "Do you want to save the document before loading another one?", 
          "Choose", 
          JOptionPane.YES_NO_CANCEL_OPTION); 
        if (response == JOptionPane.NO_OPTION) {
          // fall through and load another one
        }
        else if (response == JOptionPane.YES_OPTION) {
          setStatus("Saving document...");
          saveDocument();
          // fall through and load another one
        }
        else {
          // cancel: do nothing
          setStatus("Load was canceled",3);
          return;
        }

      }
    }

    // if we get here, we are loading data to this doc
    JFileChooser fc = new JFileChooser();
    //In response to a button click:
    int returnVal = fc.showOpenDialog(this.getWindow());
    if (returnVal == JFileChooser.APPROVE_OPTION) {
        itsDocument.setFile(fc.getSelectedFile());
        //This is where a real application would open the file.
        try {
          setStatus("Reading \"" + itsDocument.getFile().getName() + "\"");
          itsDocument.read();
          markClean();
          setStatus("done",3);
          repaint();
        }
        catch (IOException io) {
          this.setStatus("Error reading file");
        }
        finally {}
    } else {
        this.setStatus("Cancelled by user.");
    }
  }

  /**
   * UI implementation of a save document command. The save
   * command is defined as write a data file with the contents
   * of the document. This implementation does
   * the following. 1) checks if there is document with a file
   * associated with it, then it just writes the data to the file.
   * 2) if there is not file associated, then it prompts the user
   * to select a file and then saves it.
   */
  public void saveDocument()
  {
    if (itsDocument == null)
      return; // do nothing

    // if we don't have a file, let the user select one
    else if (!itsDocument.hasFile()) {
      JFileChooser fc = new JFileChooser();
      int returnVal = fc.showSaveDialog(this.getWindow());
      if (returnVal == JFileChooser.APPROVE_OPTION) {
        itsDocument.setFile(fc.getSelectedFile());
      }
    }

    // Did we select a file or did we have one already?
    if (itsDocument.hasFile()) {
      try {
        setStatus("Writing \"" + itsDocument.getFile().getAbsolutePath()+"\"");
        itsDocument.write();
        markClean();
        setStatus("done",3);
      }
      catch (IOException io) {
        this.setStatus("Error saving file");
      }
      finally {}
    }
  }

  /**
   * UI implementation of a close document command. The close
   * command is defined as giving the user an option of save
   * unsaved data first and then closing the document (and its window).
   * This implementation does the following. 1) checks if there is 
   * the document is dirty. 2) if so, then it prompts the user
   * if they want to save the document. 3) if the user says yes,
   * then the doc is save and closed. 4) if the user says no, then
   * the document is closed. 5) if the user cancels, nothing happens.
   */
  public void closeDocument()
  {
    if (itsDocument == null)
      return; // do nothing

    if (itsDocument.isDirty()) {
      // do you want to save?
      int response = JOptionPane.showConfirmDialog(this.getWindow(), 
        "Do you want to save the document before closing?", 
        "Choose", 
        JOptionPane.YES_NO_CANCEL_OPTION); 
      if (response == JOptionPane.NO_OPTION) {
        // close it
        this.closeWindow();
      }
      else if (response == JOptionPane.YES_OPTION) {
        setStatus("Saving document...");
        saveDocument();
        if (!itsDocument.isDirty())
          this.closeWindow();
      }
      else {
        // cancel: do nothing
        setStatus("Close was canceled",3);
      }
    }
    else
      this.closeWindow();
  }

  /**
   * UI implementation of a revert document command. The revert
   * command is defined as giving the user to reload the document
   * contents from file. If the document has been modified (was dirty)
   * the user will be asked first.
   * This implementation does the following. 1) checks if there is 
   * the document is dirty. 2) if so, then it prompts the user
   * if they want to revert the document. 3) if the user says yes,
   * then the doc is reverted. 4) if the user says no, then
   * the document is left alone. 5) if the document was not dirty
   * then the document is reverted automatically.
   */
  public void revertDocument()
  {
    if (itsDocument == null)
      return; // do nothing

    if (itsDocument.isDirty()) {
      int response = JOptionPane.showConfirmDialog(this.getWindow(), 
        "Do you want to revert to the saved document?", 
            "Choose", 
            JOptionPane.YES_NO_OPTION); 
      if (response == JOptionPane.NO_OPTION) {
        return;
      }
    }

    // user say "yes I want to revert" or the document
    // wasn't dirty
    try {
      setStatus("Reverting document...");
      itsDocument.read();
      markClean();
      setStatus("done",3);
      repaint();
    }
    catch (IOException io) {
      this.setStatus("Error reading file");
    }
    finally {}
  }

  /**
   * Method that gets called to draw the window content.
   * Default method does nothing. Note that this method is
   * not public.
   * @param g used for drawing
   */
  void paintCanvas(Graphics2D g) {}

  /**
   * Convenience method to force a window repaint.
   */
  public void repaint()
  {
    repaint(true);
  }

  /**
   * Convenience method to force a repaint.
   * @param all if true, then forces a repaint at the window
   * level. If false, it redraws only the canvas.
   */
  public void repaint(Boolean all)
  {
    if (all)
      getWindow().repaint();
    else
      getCanvas().repaint();
  }

  /**
   * Action Support: adds an action with the context:name
   * @param context - name for context of the action
   * @param name - name for the action
   * @param action functional interface to an action
   */
  public void addAction(String context, String name, SAction action)
  {
    actions.put(
      new SActionKey(context, name), 
      new SActionState(action));
  }

  /**
   * Action Support: given a context:name, returns the action
   * @param context - name for context of the action
   * @param name - name for the action
   * @return action associated with context:name
   */
  public SAction getAction(String context, String name)
  {
    SActionState a = actions.get(new SActionKey(context, name));
    if (a != null)
      return a.getAction();
    else
      return null;
  }

  /**
   * Action Support: given a context:name, execute the action
   * @param context - name for context of the action
   * @param name - name for the action
   */
  public void doAction(String context, String name)
  {
    SActionState a = actions.get(new SActionKey(context, name));
    if (a != null)
        a.doAction();
  }

  /**
   * Action Support: given a context:name, enable/disable the action
   * @param context - name for context of the action
   * @param name - name for the action
   * @param enable - true to enable the action, false to disable
   */
  public void enableAction(String context, String name, Boolean enable)
  {
    if (enable)
      enableAction(context, name);
    else
      disableAction(context, name);
  }

  /**
   * Action Support: given a context:name, enable the action
   * @param context - name for context of the action
   * @param name - name for the action
   */
  public void enableAction(String context, String name)
  {
    SActionState a = actions.get(new SActionKey(context, name));
    if (a != null) {
      a.enable();
      JMenuItem m = getMenuItem(context, name);
      if (m != null)
        m.setEnabled(true);
    }
  }

  /**
   * Action Support: given a context:name, disable the action
   * @param context - name for context of the action
   * @param name - name for the action
   */
  public void disableAction(String context, String name)
  {
    SActionState a = actions.get(new SActionKey(context, name));
    if (a != null) {
      a.disable();
      JMenuItem m = getMenuItem(context, name);
      if (m != null)
        m.setEnabled(false);
    }
  }

  /**
   * Given a context and name (action key), it finds a menu
   * and menuitem that match and returns it.
   * It create the JMenuItem needed and adds the action provided.
   * @param context - name for context of the action
   * @param name - name for the action
   * @return JMenuItem associated with context:name, null if not found
   */
  public JMenuItem getMenuItem(String context, String name)
  {
    for (int k = 0; k < menuBar.getMenuCount(); k++) {
      JMenu menu = menuBar.getMenu(k);
      if (menu != null && (menu.getText().equals(context))) {
        for (int i = 0; i < menu.getItemCount(); i++) {
          JMenuItem mi = menu.getItem(i);
          if (mi != null) {
            String item = mi.getText();
            if ((item != null) && (item.equals(name)))
              return mi;
          }
        }
      }
    }
    return null;
  }


  /**
   * Action Support: given a context:name, remove the action
   * @param context for the action
   * @param name for the action
   */
  // public void removeAction(String context, String name)
  // {
  //   System.out.println("Action not implemented yet.");
  // }

  /**
   * Window Support: given an action, call this action
   * on each window
   * @param action consumer action to perform on all windows
   */
  static public void forEachWindow(Consumer<SWindow> action)
  {
    theWindowList.forEach(action);
  }

  /**
   * Window Support: get number of windows
   * @return the number of windows opened
   */
  static public int getNumWindows()
  {
    return theWindowList.size();
  }

  /**
   * Returns the window in front of the list
   * @return SWindow object
   */
  static public SWindow getFrontMost()
  {
    if (theWindowList.size() > 0)
      return theWindowList.get(0);
    else
      return null;
  }

  /**
   * Window Support: removes the window passed from
   * the application list of windows.
   * @param window to be removed from list
   */
  static public void removeWindow(SWindow window)
  {
      theWindowList.remove(window);
  }

  /**
   * Window Support: brings this window to the front by
   * calling toFront() on the JFrame.
   */
  public void bringToFrontWindow()
  {
    this.getWindow().toFront();
  }

  /**
   * Window Support: Sends this window to the back by
   * calling toBack() on the JFrame.
   */
  public void sendToBackWindow()
  {
    this.getWindow().toBack();
  }

  /**
   * Window Support: maximize this window by setting the
   * extended state to MAXIMIZED_BOTH on the JFrame.
   */
  public void maximizeWindow()
  {
    this.getWindow().setExtendedState(JFrame.MAXIMIZED_BOTH);
  }

  /**
   * Window Support: minimize this window by setting the
   * extended state to ICONIFIED on the JFrame.
   */
  public void minimizeWindow()
  {
    this.getWindow().setExtendedState(JFrame.ICONIFIED);
  }

  /**
   * Window Support: closes this window, existing to
   * the OS if there are no other windows opened.
   */
  public void closeWindow()
  {
    closeWindow(true);
  }

  /**
   * Window Support: closes this window. As an indirect
   * result, if there was an acion installed, it gets
   * called.
   * @param exitIfLast - if this is the last window,
   * it will terminate the application and exit to the OS
   */
  public void closeWindow(boolean exitIfLast)
  {
    // First, remove this window from the window list
    removeWindow(this);

    // if the window list is empty, then we quit
    // the program.
    if (exitIfLast && theWindowList.size() == 0) {
      // we are closing the last window
      System.exit(0);
    }
    else {
      // we hide this window, and then dispose it
      getWindow().setVisible(false);
      getWindow().dispose();
    }
  }

  /**
   * Window Support: removes the window passed from
   * the application list of windows.
   */
  public void removeWindow()
  {
      theWindowList.remove(this);
  }
}

/*
 * Copyright: This programming assignment specification and the 
 * provided sample code are protected by copyright. The professor 
 * is the exclusive owner of copyright of this material. You are 
 * encouraged to take notes and make copies of the specification 
 * and the source code for your own educational use. However, you 
 * may not, nor may you knowingly allow others to reproduce or 
 * distribute the materials publicly without the express written 
 * consent of the professor. This includes providing materials to 
 * commercial course material suppliers such as CourseHero and 
 * other similar services. Students who publicly distribute or 
 * display or help others publicly distribute or display copies or 
 * modified copies of this material may be in violation of 
 * University Policy 406, The Code of Student Responsibility
 * https://legal.uncc.edu/policies/up-406.
 */