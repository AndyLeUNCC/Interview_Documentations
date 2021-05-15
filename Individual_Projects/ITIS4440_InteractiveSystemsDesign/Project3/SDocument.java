package uncc.project3;

/**
 * File: SDocument.java
 * ITIS 4440 User Interface Design and Implementation
 * @author manuel a perez-quinones
 * @version 1.5
 * Compile: javac SDocument.java
 * see copyright at end of file
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

/**
 * File based document as part of the SFramework. This abstract
 * class defines the protocol needed to support opening, saving,
 * and managing documents in the framework.
 */

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
   * Is this document dirty (i.e., has it been modified)?
   * @return true if the document has been modified and needs saving, false otherwise.
   */
  public boolean isDirty() { return dirty; }

  /**
   * Does this document have a file attached? Initially
   * a document exists in memory but has not been saved
   * so there is no file attached.
   * @return true if the document has a file
   */
  public boolean hasFile() { return (itsFile != null);}

  /**
   * Store the file reference with this document.
   * @param file - File object for this document
   */
  public void setFile(File file) { itsFile = file; }

  /**
   * Returns the file reference stored in this document.
   * @return the file object for this document
   */
  public File getFile() { return itsFile; }

  /**
   * Initialize a blank document. Called when a document
   * is brand new or when it is about to be loaded from
   * storage.
   */
  public void init() {}

  /**
   * Write the document data to a file.
   * @param file - File object for this document
   * @throws IOException - if any error occurs writing the file
   */
  public abstract void write(File file) throws IOException;

  /**
   * Read the document data from a file.
   * @param file - File object for this document
   * @throws IOException - if any error occurs reading the file
   */
  public abstract void read(File file) throws IOException;

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