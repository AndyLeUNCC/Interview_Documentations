package uncc.project2;

/**
 * shape4.java
 * ITIS 4440 User Interface Design and Implementation
 * @author manuel a. perez-quinones, UNC Charlotte (formerly Virginia Tech)
 * see copyright at end of file
 *
 * Requires the SFramework
 * Compile: javac shape4.java
 * Run: java shape4
 *
 */


import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class shape4 extends SWindow {
    static public void main(String args[]) {
        new shape4();
    }

    private SShape a;
    private Point lastPt;

    /**
     * Constructor for shape4
     */
    public shape4() { super("shape4"); }

    /**
     * Initialize this window by adding an action to the 
     * File:Open menu.
     */
    public void init()
    {
        a = new STriangle(100, 100);

        JMenu edit = getEditMenu();
        edit.addSeparator();

        // adding actions to menu items
        installMenuItem(edit, "Fill Red", () -> {
            a.setFill(true, Color.RED);
            repaint();
            updateMenus();
        });
        installMenuItem(edit, "Unfill", () -> {
            a.setFill(false);
            repaint();
            updateMenus();
        });
        updateMenus();
    }

    public void updateMenus()
    {
        enableAction("Edit", "Fill Red", a.isSelected());
        enableAction("Edit", "Unfill", a.isSelected());
    }

    public void mouseClicked(MouseEvent e)
    {
        if (a.contains(e.getPoint()))
            a.select(true);
        else
            a.select(false);
        repaint();
        updateMenus();
    }


    public void mousePressed(MouseEvent e)
    {
        if (a.contains(e.getPoint()) || 
            (a.inHandle(e.getPoint()) != -1)) {

            a.grabbed(e.getPoint());
            a.select(true);
        }
        else
            a.select(false);

        // save this point
        lastPt = e.getPoint();
        repaint();
        updateMenus();
    }
    public void mouseDragged(MouseEvent e) 
    {
        if (a.isSelected()) {
            int dx = (int)e.getPoint().getX() - lastPt.x;
            int dy = (int)e.getPoint().getY() - lastPt.y;
            a.dragging(dx, dy);
        }
        lastPt = e.getPoint();
        repaint();
    }
    public void mouseReleased(MouseEvent e) 
    {
        if (a.isSelected())
            a.released(e.getPoint());

        // leave the object selected
        repaint();
        updateMenus();
    }


    /**
     * Paints the canvas area by just drawing a circle
     * @param Graphics2D environment
     */
    void paintCanvas(Graphics2D g) {
        a.draw(g);
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