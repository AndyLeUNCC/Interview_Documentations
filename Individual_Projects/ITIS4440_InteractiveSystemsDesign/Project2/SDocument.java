package uncc.project2;

/**
 * File: SDocument.java
 * ITIS 4440 User Interface Design and Implementation
 * @author manuel a perez-quinones
 * @version 1
 * Compile: javac SDocument.java
 * see copyright at end of file
 *
 * Reusable Window class that includes a panel, default
 * behavior on close, and provides a hook for a subclass
 * to provide the drawing behavior.
 *
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
import javax.swing.*;
import javax.swing.filechooser.*;
import javax.swing.SwingUtilities;


public abstract class SDocument  
{
  private boolean dirty = true;
  private File itsFile = null;
  /**
   * Marks this document as modified (dirty). This flag is used
   * to decide if a "Do you want to save" question is displayed
   * when the document is being closed.
   */
  public void markDirty() {
    dirty = true;
  }

  /**
   * Marks this document clean, there are not changes to save.
   */
  public void markClean() {
    dirty = false;
  }

  /**
   * Is this document dirty (modified)?
   * @return true if the document has been modified and needs saving, false otherwise.
   */
  public boolean isDirty() { return dirty; }

  public boolean hasFile() { return (itsFile != null);}
  /**
   * @param file - File object for writing content.
   */
  public void setFile(File file) { itsFile = file; }
  public File getFile() { return itsFile; }

  /**
   * Initialize a blank document.
   */
  public abstract void init();

  /**
   * Write to a file the document data.
   * @throws IOException - if any error occurs writing the file
   */
  public abstract void write() throws IOException;

  /**
   * Read the document data from a file.
   * @throws IOException - if any error occurs reading the file
   */
  public abstract void read() throws IOException;

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