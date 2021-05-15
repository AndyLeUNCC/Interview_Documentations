package uncc.project2;

/**
 * shape1.java
 * ITIS 4440 User Interface Design and Implementation
 * @author manuel a. perez-quinones, UNC Charlotte (formerly Virginia Tech)
 * see copyright at end of file
 *
 * Requires the SFramework
 * Compile: javac shape1.java
 * Run: java shape1
 *
 */


import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/**
 * This class implements a single application that shows a circle
 * using the SShape/SCircle class.
 */
public class shape1 extends SWindow {
	static public void main(String args[]) {
		new shape1();
	}

    private SCircle a;

    /**
     * Constructor for shape1
     */
	public shape1() { super("shape1"); }

    /**
     * Initialize this window by adding some actions to the menu.
     */
	public void init()
	{
        JMenu edit = getEditMenu();
        edit.addSeparator();

        // adding actions to menu items
        installMenuItem(edit, "Select", () -> {
    		a.select(true);
    		repaint();
    	});
        installMenuItem(edit, "Unselect", () -> {
    		a.select(false);
    		repaint();
    	});
        installMenuItem(edit, "Fill Red", () -> {
        	a.setFill(true, Color.RED);
        	repaint();
		});
        installMenuItem(edit, "Unfill", () -> {
        	a.setFill(false);
        	repaint();
		});
        a = new SCircle(100, 100, 50);
	}

    /**
     * Paints the canvas area by just drawing the shape.
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