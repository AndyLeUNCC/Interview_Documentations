package uncc.project3;

/**
 * File: SLine.java
 * ITIS 4440 User Interface Design and Implementation
 * See copyright at end of file
 * @author manuel a perez-quinones
 * @version 1.5
 *
 * Requires the SFramework
 * Compile: javac SLine.java
 */

import java.awt.geom.*;
import java.awt.*;
import java.util.*;

public class SLine extends SShape
{
    /**
     * Constructor for a line part of SShape classes. It creates
     * two control points one for each point that marks the end
     * of the line. It also creates a handle for resizing the line.
     * The handle is the same as the 2nd control point. By default
     * this implementation allows resizing of the line only from
     * one end of the line.
     * @param x1 coordinate for one end point of the line
     * @param y1 coordinate for one end point of the line
     * @param x2 coordinate for the other end point of the line
     * @param y2 coordinate for the other end point of the line
     */
    public SLine(int x1, int y1, int x2, int y2)
    {
        super();
        addControl(x1, y1);    // [0]
        addControl(x2, y2); //[1]
        addHandle(getControl(1));
    }

    /**
     * Constructor for line shape, initializes state
     * from a string representation. Does
     * the work by calling the inherited constructor
     * that in turn calls fromString()
     * @param str string representation of a line
     */
    public SLine(String str)
    {
        super(str);
    }

    /**
     * Initialize (or resets) the state of this shape
     * from a string representation of a line.
     * @param str string representation of a line
     */
    @Override
    public void fromString(String str)
    {
        Scanner tokens = new Scanner(str);
        tokens.next();          // better be line
        int x1 = tokens.nextInt();
        int y1 = tokens.nextInt();
        int x2 = tokens.nextInt();
        int y2 = tokens.nextInt();

        if (getNumControl() < 2) {
            addControl(x1, y1);  // [0]
            addControl(x2, y2);  //[1]
        }
        else {
            setControl(0, x1, y1);  // [0]
            setControl(1, x2, y2);  //[1]
        }
        if (getNumHandles() < 1)
            addHandle(x2, y2);
        else
            setHandle(0, x2, y2);
    }

    /**
     * Move the line to a new location indicated by x,y. It
     * updates all control and handle points. Uses x,y as the
     * first control point.
     * @param x coordinate for one end point of the line
     * @param y coordinate for one end point of the line
     */
    public void  moveTo(int x, int y)
    {
        int w = (int)Math.abs(getControl(1).x - getControl(0).x);
        int h = (int)Math.abs(getControl(1).y - getControl(0).y);
        setControl(0, x, y);
        setControl(1, x+w, y+h);

        setHandle(0, getControl(1));
    }
    /**
     * Move (offset) the line to a new location indicated 
     * by dx,dy. It updates all control and handle points.
     * @param dx delta x for the line
     * @param dy delta x for the line
     */
    public void  updateLocation(int dx, int dy)
    {
        setControl(0, getControl(0).x + dx, getControl(0).y + dy);
        setControl(1, getControl(1).x + dx, getControl(1).y + dy);

        setHandle(0, getControl(1));
    }
    /**
     * Resize the line as a result of dragging on the
     * handle point. The resize changes the 2nd (index 1)
     * control point and updates the handle to the same
     * location.
     * @param dx delta x for the 2nd control point of the line
     * @param dy delta x for the 2nd control point of the line
     */
    public void updateSize(int dx, int dy)
    {
        int x = getControl(1).x;    //control point being moved
        int y = getControl(1).y;
        setControl(1, x+dx, y+dy);
        setHandle(0, getControl(1));
    }

    /**
     * Draw this line using the graphics object g. The drawing
     * handles numerous things. If the shape is selected a handle
     * is drawn at the handle point. The handle drawing calls
     * drawHandles() inherited from SShape. 
     * @param g Graphics2D
     */
    public void draw(Graphics2D g)
    {
        g.setColor(getBorderColor());
        g.drawLine(getControl(0).x, getControl(0).y,
            getControl(1).x, getControl(1).y);

        if (isSelected()) {
            g.setColor(Color.BLACK);
            drawHandles(g);
        }
    }

    /**
     * Tests if a specified Point2D is the line or close enough
     * to the line. Testing for the point on the line is based
     * on a simple math trick. If point b is between a and c
     * (where a and c are the two end points of the line), then
     * the distance from a-b and b-c when added together should
     * be the same as teh distance between a to c. We add 5 units
     * as a way to allow a small gravity field around the line.
     * @param b point to test if it is on the line
     * @return true if b is on the line, false otherwise.
     */
    public boolean contains(Point2D b)
    {
        Point a = getControl(0);
        Point c = getControl(1);
        return ((Math.abs(a.distance(b) + b.distance(c) - a.distance(c))) < 5);
    }

    /**
     * Returns a rectangle that marks the bounding box of the line. The
     * rectangle will has as top left x coordinate the smallest 
     * x of the two control points and y coordinate as the smallest
     * y of the two control points. The width and height is computed
     * as the absolute value of the different of the two x and y
     * appropriately.
     * @return bounding box for the circle
     */
    public Rectangle getBounds()
    {
        int x = (int)Math.min(getControl(0).x, getControl(1).x);
        int y = (int)Math.min(getControl(0).y, getControl(1).y);
        int w = (int)Math.abs(getControl(1).x - getControl(0).x);
        int h = (int)Math.abs(getControl(1).y - getControl(0).y);
        return new Rectangle(x, y, w, h);
    }

    /**
     * Converts this object into a string representation
     * showing the x,y for the two endpoints of the line.
     * @return string representation of the shape
     */

    @Override
    public String toString()
    {
        Point p1 = getControl(0);
        Point p2 = getControl(1);
        String s = super.toString() + 
            "line "+p1.x+" "+p1.y+" "+p2.x+" "+p2.y+"\n";
        return s;
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