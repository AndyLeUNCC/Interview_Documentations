package uncc.project3;

/**
 * File: SRectangle.java
 * ITIS 4440 User Interface Design and Implementation
 * See copyright at end of file
 * @author manuel a perez-quinones
 * @version 1.5
 *
 * Requires the SFramework
 * Compile: javac SRectangle.java
 */

import java.awt.geom.*;
import java.awt.*;
import java.util.*;

public class SRectangle extends SShape
{
    /**
     * Constructor for rectangle part of SShape classes. It 
     * creates two control points, one for the topLeft of the
     * rectangle and the other for the diagonally opposite
     * corner. This second control point is obtained by adding
     * w,h to the topLeft. It also creates a handle for resizing
     * the rectangle. The handle is the same as the 2nd control point.
     * @param x coordinate for the topLeft.x of the rectangle
     * @param y coordinate for the topLeft.y of the rectangle
     * @param w width of the rectangle
     * @param h height of the rectangle
     */
    public SRectangle(int x, int y, int w, int h)
    {
        super();
        addControl(x, y);     // [0]
        addControl(x+w, y+h); // [1]
        addHandle(getControl(1));    // handle at bottom-right
    }

    /**
     * Constructor for rectangle, initializes state
     * from a string representation. Does
     * the work by calling the inherited constructor
     * that in turn calls fromString()
     * @param str string representation of a rectangle
     */
    public SRectangle(String str)
    {
        super(str);
    }

    /**
     * Initialize (or resets) the state of this shape
     * from a string representation of a rectangle.
     * @param str string representation of a rectangle
     */
    @Override
    public void fromString(String str)
    {
        Scanner tokens = new Scanner(str);
        tokens.next();  // better be rectangle
        int x = tokens.nextInt();
        int y = tokens.nextInt();
        int w = tokens.nextInt();
        int h = tokens.nextInt();

        if (getNumControl() < 2) {
            addControl(x, y);  // [0]
            addControl(x+w, y+h);  //[1]
        }
        else {
            setControl(0, x, y);  // [0]
            setControl(1, x+w, y+h);  //[1]
        }
        if (getNumHandles() < 1)
            addHandle(x+w, y+h);
        else
            setHandle(0, x+w, y+h);
    }

    /**
     * Move the rectangle to a new location indicated by x,y. It
     * updates all control and handle points.
     * @param x coordinate for the topLeft.x of the rectangle
     * @param y coordinate for the topLeft.y of the rectangle
     */
    public void  moveTo(int x, int y)
    {
        int w = getWidth();
        int h = getHeight();
        setControl(0, (int)x, (int)y);
        setControl(1, (int)x+w, (int)y+h);
        setHandle(0, getControl(1));
    }
    /**
     * Return the width of the rectangle.
     * @return int width of the rectangle.
     */
    public int getWidth()
    {
        return (int)Math.abs(getControl(1).x - getControl(0).x);
    }
    /**
     * Return the height of the rectangle.
     * @return int height of the rectangle.
     */
    public int getHeight()
    {
        return (int)Math.abs(getControl(1).y - getControl(0).y);
    }

    /**
     * Move (offset) the rectangle to a new location indicated 
     * by dx,dy. It updates all control and handle points.
     * @param dx delta x for new the topLeft of the rectangle.
     * @param dy delta y for new the topLeft of the rectangle.
     */
    public void  updateLocation(int dx, int dy)
    {
        // current location
        int x = getControl(0).x;    //topleft.x
        int y = getControl(0).y;    //topleft.y
        // current width
        int w = getWidth();
        int h = getHeight();
        setControl(0, x+dx, y+dy);
        setControl(1, x+w+dx, y+h+dy);
        setHandle(0, getControl(1));
    }

    /**
     * Resize the rectangle as a result of dragging on the
     * handle point. The resize changes the 2nd (index 1)
     * control point and updates the handle to the same
     * location.
     * @param dx delta x for resizing the rectangle.
     * @param dy delta y for resizing the rectangle.
     */
    public void updateSize(int dx, int dy)
    {
        int x = getControl(1).x;    //control point being moved
        int y = getControl(1).y;
        x = (int)Math.abs(x + dx);  // new point (bottom right)
        y = (int)Math.abs(y + dy);
        setControl(1, x, y);
        setHandle(0, getControl(1));
    }

    /**
     * Draw this rectangle using the graphics object g. The drawing
     * handles numerous things. If the shape is filled, it uses
     * the fillColor to paint the fill the circle. If the shape
     * is selected a handle is drawn at the bottom right corner
     * of the rectangle. The handle drawing calls drawHandles()
     * inherited from SShape.
     * @param g Graphics2D
     */
    public void draw(Graphics2D g)
    {
        int w = getWidth();
        int h = getHeight();
        if (isFilled()) {
            g.setColor(getFillColor());
            g.fillRect(getControl(0).x, getControl(0).y, w, h);
        }

        g.setColor(getBorderColor());
        g.drawRect(getControl(0).x, getControl(0).y, w, h);

        if (isSelected()) {
            g.setColor(Color.BLACK);
            drawHandles(g);
        }
    }

    /**
     * Tests if a specified Point2D is inside the boundary of the 
     * rectangle.
     * @param p point to test if it is inside of the rectangle
     * @return true if p is inside of the rectangle, false otherwise.
     */
    public boolean contains(Point2D p)
    {
        int w = getWidth();
        int h = getHeight();
        return 
            ((p.getX() >= getControl(0).x) && (p.getX() < getControl(0).x+w) &&
             (p.getY() >= getControl(0).y) && (p.getY() < getControl(0).y+h));
    }

    /**
     * Returns a rectangle that marks the bounding box of the
     * rectangle. The bounding box is the same as the rectangle.
     * @return bounding box for the rectangle
     */
    public Rectangle getBounds()
    {
        return new Rectangle(getControl(0).x, getControl(0).y,
            getWidth(), getHeight());
    }

    /**
     * Converts this object into a string representation
     * showing the top left x,y and the width and height of
     * the rectangle.
     * @return string representation of the shape
     */
    @Override
    public String toString()
    {
        Point p = getControl(0);    //topLeft
        String s = super.toString() + 
            "rectangle "+p.x+" "+p.y+" "+getWidth()+" "+getHeight()+"\n";
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