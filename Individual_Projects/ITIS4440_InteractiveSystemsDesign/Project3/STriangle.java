package uncc.project3;

/**
 * File: STriangle.java
 * ITIS 4440 User Interface Design and Implementation
 * See copyright at end of file
 * @author manuel a perez-quinones
 * @version 1.5
 *
 * Requires the SFramework
 * Compile: javac STriangle.java
 */

import java.awt.geom.*;
import java.awt.*;
import java.util.*;

public class STriangle extends SShape
{
    private Polygon p = null;

    /**
     * Constructor for triangle object of SShape classes. It 
     * implements an isosceles triangle with a base of
     * 100 and height of 100. It creates three control points,
     * one for each of the vertices. It also creates a handle
     * for resizing the triangle at the 3rd control point of the
     * triangle. Internally this shape is implemented by using
     * a Java Polygon.
     * @param x1 coordinate for the top vertex of the triangle
     * @param y1 coordinate for the top vertex of the triangle
     */
    public STriangle(int x1, int y1)
    {
        this(x1,y1,100,100);
    }

    /**
     * Constructor for triangle shape, initializes state
     * from a string representation. Does
     * the work by calling the inherited constructor
     * that in turn calls fromString()
     * @param str string representation of a triangle
     */
    public STriangle(String str)
    {
        super(str);
    }

    /**
     * Initialize (or resets) the state of this shape
     * from a string representation of a triangle.
     * @param str string representation of a triangle
     */
    @Override
    public void fromString(String str)
    {
        Scanner tokens = new Scanner(str);
        tokens.next();      // better be triangle
        int x1 = tokens.nextInt();
        int y1 = tokens.nextInt();
        int x2 = tokens.nextInt();
        int y2 = tokens.nextInt();
        int x3 = tokens.nextInt();
        int y3 = tokens.nextInt();

        if (getNumControl() < 3) {
            addControl(x1, y1);         //[0]
            addControl(x2, y2);         //[1]
            addControl(x3, y3);         //[2]
        }
        else {
            setControl(0, x1, y1);         //[0]
            setControl(1, x2, y2);         //[1]
            setControl(2, x3, y3);         //[2]
        }
        if (getNumHandles() < 1)
            addHandle(x2, y2);
        else
            setHandle(0, x2, y2);

        createPolygon();
    }

    /**
     * Constructor for triangle object of SShape classes. It 
     * implements an isosceles triangle with a base and height
     * specified by the parameters. It creates three control points,
     * one for each of the vertices. It also creates a handle
     * for resizing the triangle at the 3rd control point of the
     * triangle. Internally this shape is implemented by using
     * a Java Polygon.
     * @param x1 coordinate for the top vertex of the triangle
     * @param y1 coordinate for the top vertex of the triangle
     * @param base width of the base of the isosceles triangle
     * @param height of the isosceles triangle
     */
    public STriangle(int x1, int y1, int base, int height)
    {
        super();
        addControl(x1, y1);         //[0]
        addControl((int)(x1-(base/2.0)), y1+height);  //[1]
        addControl((int)(x1+(base/2.0)), y1+height);  //[2]
        addHandle(getControl(2));

        createPolygon();
    }


    /**
     * Constructor for triangle object of SShape classes. It 
     * implements a triangle specified by the parameters. 
     * It creates three control points,
     * one for each of the vertices. It also creates a handle
     * for resizing the triangle at the 3rd control point of the
     * triangle. Internally this shape is implemented by using
     * a Java Polygon.
     * @param x1 coordinate for the top vertex of the triangle
     * @param y1 coordinate for the top vertex of the triangle
     * @param x2 coordinate for the top vertex of the triangle
     * @param y2 coordinate for the top vertex of the triangle
     * @param x3 coordinate for the top vertex of the triangle
     * @param y3 coordinate for the top vertex of the triangle
     */
    public STriangle(int x1, int y1, int x2, int y2, int x3, int y3)
    {
        super();
        addControl(x1, y1);         //[0]
        addControl(x2, y2);         //[1]
        addControl(x3, y3);         //[2]
        addHandle(getControl(2));

        createPolygon();
    }
    /**
     * Internal method to create a polygon based on the
     * three control points.
     */
    private void createPolygon()
    {
        p = new Polygon();
        p.addPoint(getControl(0).x, getControl(0).y);
        p.addPoint(getControl(1).x, getControl(1).y);
        p.addPoint(getControl(2).x, getControl(2).y);
    }

    /**
     * Move the triangle to a new location indicated by x,y. It
     * updates all control and handle points.
     * @param x coordinate for the top vertex of the triangle
     * @param y coordinate for the top vertex of the triangle
     */
    public void  moveTo(int x, int y)
    {
        int w = (int)Math.abs(getControl(1).x - getControl(0).x);
        int h = (int)Math.abs(getControl(1).y - getControl(0).y);
        setControl(0, x, y);
        setControl(1, getControl(1).x+w, getControl(1).y+h);
        setControl(2, getControl(2).x+w, getControl(2).y+h);

        setHandle(0, getControl(2));
        p = null;   // force a recalculation of the polygon
    }

    /**
     * Move (offset) the triangle to a new location indicated 
     * by dx,dy. It updates all control and handle points.
     * @param dx delta x for the move of the triangle.
     * @param dy delta y for the move of the triangle.
     */
    public void  updateLocation(int dx, int dy)
    {
        setControl(0, getControl(0).x + dx, getControl(0).y + dy);
        setControl(1, getControl(1).x + dx, getControl(1).y + dy);
        setControl(2, getControl(2).x + dx, getControl(2).y + dy);

        setHandle(0, getControl(2));
        p = null;   // force a recalculation
    }

    /**
     * Resize the triangle as a result of dragging on the
     * handle point. The resize changes the 3rd (index 2)
     * control point and updates the handle to the same
     * location.
     * @param dx delta x for resizing the triangle.
     * @param dy delta y for resizing the triangle.
     */
    public void updateSize(int dx, int dy)
    {
        setControl(2, getControl(2).x+dx, getControl(2).y+dy);
        setHandle(0, getControl(2));
        p = null;   // force a recalculation
    }

    /**
     * Draw this triangle using the graphics object g. The drawing
     * is done with the Java Polygon class. It creates the
     * internal polygon class on demand as needed. If the shape
     * is filled, it uses the fillColor to paint the fill the 
     * polygon (triangle). If the shape is selected a handle is
     * drawn at the appropriate control point.
     * The handle drawing calls drawHandles() inherited from SShape.
     * @param g Graphics2D
     */
    public void draw(Graphics2D g)
    {
        if (p == null)
            createPolygon();

        if (isFilled()) {
            g.setColor(getFillColor());
            g.fillPolygon(p);
        }

        g.setColor(getBorderColor());
        g.drawPolygon(p);

        if (isSelected()) {
            g.setColor(Color.BLACK);
            drawHandles(g);
        }
    }

    /**
     * Tests if a specified Point2D is inside the boundary of the 
     * polygon. Test is implemented using the Polygon class.
     * @param a point to test if it is inside of the rectangle
     * @return true if a is inside of the rectangle, false otherwise.
     */
    public boolean contains(Point2D a)
    {
        if (p == null)
            createPolygon();
        return p.contains(a);
    }

    /**
     * Returns a rectangle that marks the bounding box of the
     * triangle.
     * @return bounding box for the triangle
     */
    public Rectangle getBounds()
    {
        if (p == null)
            createPolygon();
        return p.getBounds();
    }

    /**
     * Converts this object into a string representation
     * showing the three x,y control points.
     * @return string representation of the shape
     */

    @Override
    public String toString()
    {
        String s = "triangle "+
            getControl(0).x+" "+getControl(0).y+" "+
            getControl(1).x+" "+getControl(1).y+" "+
            getControl(2).x+" "+getControl(2).y+"\n";
        return super.toString() + s;
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