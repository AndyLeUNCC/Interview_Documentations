package uncc.project3;

/**
 * document1.java
 * ITIS 4440 User Interface Design and Implementation
 * @author: manuel a perez-quinones
 * Compile:
 *  javac -classpath .:./SFramework.jar document1.java
 * Run:
 *  java -classpath .:./SFramework.jar document1
 *
 * See copyright at end of file
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.io.*;
import java.util.*;

public class document1 extends SWindow {
    static public void main(String args[]) {
        new document1();
    }

    /** instance variable */
    private String message = "Hello world";

    /**
     * Constructor for document1 example.
     */
    public document1() {
        super("Document");
    }

    /**
     * initializer for document1 example.
     */
    @Override
    public void init()
    {
        /** add action to the Quit menu */
        addAction("Document", "Quit", ()-> System.exit(1));
        /** add action to the File > New menu */
        addAction("File", "New", ()-> new document1());

        // The reason for the document
        attachDocument(new SDocument() {
            /**
             * Write contents of the document to file.
             * @param file File object where to write
             */
            @Override
            public void write(File file) throws IOException 
            {
                // Java's file writer stream
                FileWriter outStream = 
                    new FileWriter(file.getAbsolutePath());
                
                // Write the message and add a newline at end
                outStream.write(message+"\n");

                // Close file
                outStream.close();
            }
            /**
             * Read contents of the document from a file.
             * @param file File object from where to read
             */
            @Override
            public void read(File file) throws IOException 
            {
                Scanner s = null;
                try {
                    // Create a scanner for the File
                    s = new Scanner(file);

                    // read the full line
                    message = s.nextLine();
                }
                finally {
                    // if there is an exception or if it
                    // terminates normally, we close the
                    // scanner/file
                    if (s != null)
                        s.close();
                }

                // Because we read new string into message,
                // let's redraw it
                repaint();
            }
        });
    }

    /**
     * Display a JOptionPane to collect input from
     * the user.
     * @param e mouse event that caused the click
     */
    @Override
    public void mouseClicked(MouseEvent e)
    {
        String s = JOptionPane.showInputDialog(getWindow(), "Anyone there?", message);
        if (s != null) {
            message = s;
            setStatus(message);
            markDirty();
            repaint();
        }
    }

    /**
     * Draw the message that is stored in the
     * instance variable.
     * @param g graphics context
     */
    @Override
    public void paintCanvas(Graphics2D g)
    {
        g.drawString(message, 10, 30);
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