package uncc.project3;

/**
 * document3.java
 * ITIS 4440/6370 User Interface Design and Implementation
 * @author manuel a. perez-quinones, UNC Charlotte (formerly Virginia Tech)
 * see copyright at end of file
 *
 * Requires the SFramework
 * Compile: javac document3.java
 * Run: java document3
 *
 */

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;
import java.util.*;
import java.io.*;
import java.io.IOException;

public class document3 extends SWindow {
	static public void main(String args[]) {
		new document3();
	}

	// document3 class is below
	private Point topLeft = new Point(20, 20);
	private int size;

	public document3() {
		super("document3");
	}

	@Override
	public void init() {
	    super.init();	// do the other inits

	    // initialize a size
		size = (int)(Math.random() * 200) + 50;

		// new menu simply creates a new doc
	    addAction("File", "New", () -> new document3());

	    // Change size will change the size of the circle
        JMenu edit = getEditMenu();
        edit.addSeparator();
        installMenuItem(edit, new JMenuItem("Change size"), 
            () -> {
				size = (int)(Math.random() * 200) + 50;
				markDirty();
				repaint();
            });

        // We attach a document to save the data
	    attachDocument(new SDocument() {
			@Override
			public void read(File file) throws IOException
			{
				Scanner s = null;
				try {
					s = new Scanner(new BufferedReader(new FileReader(file.getAbsolutePath())));
					topLeft.x = s.nextInt();
					topLeft.y = s.nextInt();
					size = s.nextInt();
				}
				finally {
					if (s != null)
						s.close();
				}
			}
			@Override
			public void write(File file) throws IOException
			{
				FileWriter outStream = new FileWriter(file.getAbsolutePath());
				outStream.write(topLeft.x+"\n");
				outStream.write(topLeft.y+"\n");
				outStream.write(size+"\n");
				outStream.close();
			}
	    });
	}


    @Override
    public void paintCanvas(Graphics2D g) {
		g.drawOval((int)topLeft.getX(), (int)topLeft.getY(), size, size);
	}

	@Override
	public void mouseClicked(MouseEvent e) {
		topLeft = e.getPoint();
		repaint();
		markDirty();
	}

	@Override
	public void mouseDragged(MouseEvent e) {
		mouseClicked(e);
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