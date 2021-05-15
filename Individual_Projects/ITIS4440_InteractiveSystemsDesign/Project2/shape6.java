package uncc.project2;

/**
 * shape6.java
 * ITIS 4440 User Interface Design and Implementation
 * @author manuel a. perez-quinones, UNC Charlotte (formerly Virginia Tech)
 * see copyright at end of file
 *
 * Requires the SFramework
 * Compile: javac shape6.java
 * Run: java shape6
 *
 */


import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;

public class shape6 extends SWindow {
    static public void main(String args[]) {
        new shape6();
    }

    private ArrayList<SShape> list;
    private Point lastPt;

    /**
     * Constructor for shape6
     */
    public shape6() { super("shape6"); }

    /**
     * Initialize this window by adding an action to the 
     * File:Open menu.
     */
    public void init()
    {
        list = new ArrayList<SShape>();

        JMenu edit = getEditMenu();
        edit.addSeparator();

        // adding actions to menu items
        installMenuItem(edit, "New Triangle", () -> {
            list.add(new STriangle(100, 100));
            repaint();
            updateMenus();
        });
        installMenuItem(edit, "New Circle", () -> {
            list.add(new SCircle(120, 100, 35));
            repaint();
            updateMenus();
        });
        installMenuItem(edit, "Fill Red", () -> {
            for (SShape a : list)
                if (a.isSelected())
                    a.setFill(true, Color.RED);
            repaint();
            updateMenus();
        });
        updateMenus();
    }

    public void updateMenus()
    {
        enableAction("Edit", "Fill Red", false);
        for (SShape a : list) {
            if (a.isSelected()) {
                enableAction("Edit", "Fill Red", true);
                enableAction("Edit", "Unfill", true);
            }
        }
    }

    public void mouseClicked(MouseEvent e)
    {
        for (SShape a : list) {
            if (a.contains(e.getPoint()))
                a.select(true);
            else
                a.select(false);
        }
        repaint();
        updateMenus();
    }

    /**
     * Paints the canvas area by just drawing a circle
     * @param Graphics2D environment
     */
    void paintCanvas(Graphics2D g) {
        for (SShape a : list) {
            a.draw(g);
        }
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