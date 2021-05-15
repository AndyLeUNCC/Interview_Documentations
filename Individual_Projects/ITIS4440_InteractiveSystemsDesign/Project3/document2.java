package uncc.project3;

/**
 * document2.java
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

public class document2 extends SWindow {
    static public void main(String args[]) {
        new document2();
    }

    /** instance variables */
    private SCircle oneShape = new SCircle(70, 70, 40);
    private Point lastPt;
    private Random rand = new Random();

    /**
     * Constructor for document2 example.
     */
    public document2() {
        super("Document");
    }

    /**
     * initializer for document2 example.
     */
    @Override
    public void init()
    {
        /** add action to the Quit menu */
        addAction("Document", "Quit", ()-> System.exit(1));
        /** add action to the File > New menu */
        addAction("File", "New", ()-> new document2());
        addAction("File", "Close", ()-> closeWindow());

        oneShape.setFill(true, Color.red);

        JMenu shapesMenu = new JMenu("Shapes");
        installMenuItem(shapesMenu, "New Circle", () -> {
            oneShape = new SCircle(rand.nextInt(200), 
                rand.nextInt(200), rand.nextInt(95));
            repaint();
        });

        shapesMenu.addSeparator();
        installMenuItem(shapesMenu, "Fill in Color", () -> {
            Color color = new Color(
                rand.nextInt(255),
                rand.nextInt(255),
                rand.nextInt(255));
            oneShape.setFill(true, color);
            markDirty();
            repaint();
        });

        // Don't forget to do this... install the window menu
        getMenuBar().add(shapesMenu);

        // The reason for the document
        attachDocument(new SDocument() {
            /**
             * Write contents of the document to file.
             * @param file File object where to write
             */
            @Override
            public void write(File file) throws IOException 
            {
                setStatus("write(\"" + file.getAbsolutePath()+"\")");

                FileWriter outStream = new FileWriter(file.getAbsolutePath());
                Point p = oneShape.getControl(0);
                // Writes out "color c" where c is a number that represents
                // the RGB value for the fill color for this shape
                outStream.write("color ");
                outStream.write(String.valueOf(oneShape.getFillColor().getRGB())+"\n");

                // Writes out "circle x y r"
                outStream.write("circle ");
                outStream.write(p.x+" ");
                outStream.write(p.y+" ");
                outStream.write(oneShape.getRadius()+"\n");
                outStream.close();

                setStatus("done");
            }
            /**
             * Read contents of the document from a file.
             * @param file File object from where to read
             */
            @Override
            public void read(File file) throws IOException 
            {
                Scanner s = null;
                setStatus("read(\"" + file.getName() + "\")");
                try {
                    s = new Scanner(file);
                    String token = s.next();    // color
                    // Reads the "color c"
                    Color fill = new Color(s.nextInt());

                    // Reads the "circle x y r"
                    token = s.next();    // circle
                    int x = s.nextInt(); // x
                    int y = s.nextInt(); // y
                    int r = s.nextInt(); // r
                    oneShape = new SCircle(x, y, r);
                    oneShape.setFill(true, fill);  // set the color
                }
                finally {
                    if (s != null)
                        s.close();
                }
                setStatus("read the circle");
                markClean();
                repaint();
            }
        });

    }

    /**
     * Select the 1 circle that is displayed by this example.
     * @param e mouse event that caused the click
     */
    @Override
    public void mouseClicked(MouseEvent e)
    {
        oneShape.select(oneShape.contains(e.getPoint()));
        markDirty();
        repaint();
    }

    /**
     * Mouse response for when mouse is pressed in canvas, 
     * possibly grabbing the circle for dragging. Saves mouse
     * location in the lastPt instance variable.
     * @param e mouse event that caused the mouse press
     */
    @Override
    public void mousePressed(MouseEvent e) {
        boolean b = (oneShape.contains(e.getPoint()) || 
                (oneShape.inHandle(e.getPoint()) != -1));
        if (b)
            oneShape.grabbed(e.getPoint());
        oneShape.select(b);
        lastPt = e.getPoint();  // save the last point
        markDirty();
        repaint();
    }

    /**
     * Mouse response for when mouse is dragged in canvas,
     * moving the circle. Saves mouse location in the lastPt
     * instance variable.
     * @param e mouse event that caused the mouse drag
     */
    @Override
    public void mouseDragged(MouseEvent e) 
    {
        if (oneShape.isSelected()) {
            int dx = (int)e.getPoint().getX() - lastPt.x;
            int dy = (int)e.getPoint().getY() - lastPt.y;
            oneShape.dragging(dx, dy);
        }
        lastPt = e.getPoint();  // save the last point
        markDirty();
        repaint();
    }

    /**
     * Mouse release, dropping the circle at this location.
     * @param e mouse event that caused the mouse was released
     */
    @Override
    public void mouseReleased(MouseEvent e) 
    {
        if (oneShape.isSelected())
            oneShape.released(e.getPoint());
        markDirty();
        repaint();
    }

    /**
     * Draws the one circle.
     * @param g graphics context
     */
    @Override
    public void paintCanvas(Graphics2D g)
    {
        oneShape.draw(g);
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