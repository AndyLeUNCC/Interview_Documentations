package uncc.project2;

/**
 * File: SShape.java
 * ITIS 4440 User Interface Design and Implementation
 * See copyright at end of file
 * @author manuel a perez-quinones
 * @version 1.1
 *
 * Requires the SFramework
 * Compile: javac SShape.java
 */


import java.awt.geom.*;
import java.awt.*;
import java.util.*;

public abstract class SShape
{
    private static final int HANDLE_SIZE = 6;
    private static final int HANDLE_HALF_SIZE = (int)(HANDLE_SIZE / 2.0);

    private boolean selected;
    private Color borderColor = Color.BLACK;
    private boolean filled;
    private Color fillColor = null;
    private ArrayList<Point> control;   // control points
    private ArrayList<Point> handles;   // where to draw handles
    private Point lastPt = null;
    private boolean resizingShape = false;

    /**
     * Constructor for the SShape class. This is an abstract
     * class that provides the basic behavior shapes that can
     * be selected, dragged, and resized. The default behavior
     * captures the following properties: selected, filled, 
     * fill collor, and the selection color (read only). In
     * addition, SShapes have a list of control points and a
     * list of handles. The control points provide the basis
     * drawing the shape, however the meaning of the control
     * points is defined by subclasses of this class. For example
     * for a circle, control point 0 could be the center and
     * control point 1 could be a point in the circumference of
     * the circle. This class also implements a list of handles.
     * Handles are small rectangles that are drawn when the
     * shape is selected. This base class implements the handle
     * list and uses it to check if the user clicks inside of a
     * handle.
     */
    public SShape()
    {
        selected = false;
        filled = false;
        handles = new ArrayList<Point>();
        control = new ArrayList<Point>();
    }

    /**
     * Returns true if this shape is selected, false otherwise.
     * @return true if this shape is selected, false otherwise.
     */
    public boolean isSelected() { return selected; }

    /**
     * Sets this shape selection property to the parameter
     * passed in the call.
     * @param s selection flag
     */
    public void select(Boolean s) { selected = s; }

    /**
     * Returns true if the shape fill property is true.
     * @return true if the shape fill property is true, false
     * otherwise.
     */
    public boolean isFilled() { return filled; }

    /**
     * Sets the fill property to the parameter passed in the call
     * and sets the fillColor property to the color passed in the
     * call.
     * @param f fill flag
     * @param c color
     */
    public void setFill(Boolean f, Color c) {
        setFillColor(c);
        setFill(f);
    }

    /**
     * Sets the fill property to the parameter passed in the call.
     * @param f fill flag
     */
    public void setFill(Boolean f)
    {
        filled = f;
        if (fillColor == null)
            fillColor = borderColor;
    }

    /**
     * Sets the fillColor property to the color passed in the
     * call.
     * @param c color
     */
    public void setFillColor(Color c) { fillColor = c; }


    /**
     * Return the fill color property.
     * @return fill color property
     */
    public Color getFillColor() { return fillColor; }

    /**
     * Sets the borderColor property to the color passed in the
     * call.
     * @param b color
     */
    public void setBorderColor(Color b) { borderColor = b;}

    /**
     * Returns the border color property.
     * @return color for the border color
     */
    public Color getBorderColor() { return borderColor;}


    /**
     * Adds a control point to the control list for this
     * shape. Control point is added at end of control
     * list.
     * @param p point to be added 
     */
    public void addControl(Point p)
    {
        control.add(p);
    }

    /**
     * Adds a control point to the control list for this
     * shape. Control point is added at end of control
     * list.
     * @param x coordinate for the point
     * @param y coordinate for the point
     */
    public void addControl(int x, int y)
    {
        addControl(new Point(x, y));
    }


    /**
     * Return the ith control point from the control
     * list.
     * @param i index into control list
     * @return point at i location
     */
    public Point getControl(int i)
    {
        return control.get(i);
    }

    /**
     * Set the ith control point in the control list to the
     * point passed as argument.
     * @param i index into control list
     * @param p point to be stored
     */
    public void setControl(int i, Point p)
    {
        control.set(i, p);
    }

    /**
     * Set the ith control point in the control list to the
     * x,y passed as argument.
     * @param i index into control list
     * @param x coordinate for the point
     * @param y coordinate for the point
     */
    public void setControl(int i, int x, int y)
    {
        setControl(i, new Point(x,y));
    }

    /**
     * Adds a handle point to the handle list for this
     * shape. Handle point is added at end of the list.
     * @param p point to be added 
     */
    public void addHandle(Point p)
    {
        handles.add(p);
    }

    /**
     * Adds a handle point to the handle list for this
     * shape. Handle point is added at end of the list.
     * @param x coordinate for the point
     * @param y coordinate for the point
     */
    public void addHandle(int x, int y)
    {
        addHandle(new Point(x, y));
    }

    /**
     * Return the ith handle point from the handle
     * list.
     * @param i index into handle list
     * @return point at i location
     */
    public Point getHandle(int i)
    {
        return handles.get(i);
    }

    /**
     * Set the ith handle point in the handle list to the
     * point passed as argument.
     * @param i index into handle list
     * @param p point to be stored
     */
    public void setHandle(int i, Point p)
    {
        handles.set(i, p);
    }

    /**
     * Set the ith handle point in the handle list to the
     * x,y passed as argument.
     * @param i index into handle list
     * @param x coordinate for the point
     * @param y coordinate for the point
     */
    public void setHandle(int i, int x, int y)
    {
        setHandle(i, new Point(x,y));
    }


    /**
     * Draw all the handles stored in the handle list.
     * The handle point is meant to be the center of
     * the handle. The size of the handle is based on
     * an internal constant stored in this class.
     * @param g graphics object
     */
    public void drawHandles(Graphics2D g)
    {
        for (Point p : handles)
            drawHandle(g, p);
    }

    /**
     * Internal method that draws a handle.
     * @param g graphics object for drawing
     * @param x coordinate for the center of the handle
     * @param y coordinate for the center of the handle
     */
    private void drawHandle(Graphics2D g, int x, int y)
    {
        g.fillRect(x-HANDLE_HALF_SIZE, y-HANDLE_HALF_SIZE,
            HANDLE_SIZE, HANDLE_SIZE);
    }


    /**
     * Internal method that draws a handle.
     * @param g graphics object for drawing
     * @param p point the center of the handle
     */
    private void drawHandle(Graphics2D g, Point p)
    {
        drawHandle(g, (int)p.getX(), (int)p.getY());
    }

    /**
     * Abstract method to draw the shape.
     * @param g Graphics object
     */
    public abstract void draw(Graphics2D g);

    /**
     * Returns a rectangle as bounding box of the SShape.
     * The default method iterates over all of the
     * control points and finds the min x/y for the topLeft
     * and uses the width/height of the shape for the bounding
     * box. Subclasses might be able to calculate the bounding
     * box more efficiently.
     * @return bounding box for the shape
     */
    public Rectangle getBounds()
    {
        int ymin = Integer.MAX_VALUE;
        int xmin = Integer.MAX_VALUE;

        for (Point p : control) {
            xmin = (int)Math.min(xmin, p.x);
            ymin = (int)Math.min(ymin, p.y);
        }
        return new Rectangle(xmin, ymin, getWidth(), getHeight());
    }

    /**
     * Return the width of the shape. The default
     * method iterates over all of the control points
     * and finds the min/max x and uses that to calculate
     * the width of the shape. Subclasses might be
     * able to calculate that more efficiently.
     * @return int width of the shape.
     */
    public int getWidth()
    {
        int xmin = Integer.MAX_VALUE;
        int xmax = Integer.MIN_VALUE;
        for (Point p : control) {
            xmin = (int)Math.min(xmin, p.x);
            xmax = (int)Math.max(xmax, p.x);
        }
        return xmax - xmin; // width
    }

    /**
     * Return the height of the shape. The default
     * method iterates over all of the control points
     * and finds the min/max y and uses that to calculate
     * the height of the shape. Subclasses might be
     * able to calculate that more efficiently.
     * @return int height of the shape.
     */
    public int getHeight()
    {
        int ymin = Integer.MAX_VALUE;
        int ymax = Integer.MIN_VALUE;
        for (Point p : control) {
            ymin = (int)Math.min(ymin, p.y);
            ymax = (int)Math.max(ymax, p.y);
        }
        return ymax - ymin; // height
    }

    /**
     * Tests if a specified Point2D is inside the boundary of the 
     * Shape, as described by the definition of insideness.
     * @param p point to test
     * @return true if p is inside of the shape, false otherwise.
     */
    public abstract boolean contains(Point2D p);


    /**
     * Tests if a specified Point2D is inside one of the handles
     * of the Shape.
     * @param p point to test
     * @return index to the handle if found, -1 if not found
     */
    public int inHandle(Point2D p)
    {
        int i = 0;
        for (Point c : handles) {
            if (((p.getX() >= c.getX()-HANDLE_HALF_SIZE) && 
                 (p.getX() <= c.getX()+HANDLE_HALF_SIZE) &&
                 (p.getY() >= c.getY()-HANDLE_HALF_SIZE) && 
                 (p.getY() <= c.getY()+HANDLE_HALF_SIZE)))
                return i;
            i++;
        }
        return -1;
    }

    /**
     * Returns the last point reported in the grabbed(),
     * dragging(), or released() method.
     * @return point for the last reported mouse location.
     */
    public Point getCurrPoint() { return lastPt; }

    /**
     * Returns true if we are resizing a shape.
     * @return true if in the middle of a mouse operation
     * resizing this shape.
     */
    public boolean isBeingResized() { return resizingShape; }

    /**
     * Method called when the mouse is pressed inside of
     * the shape or inside of one of the handle points. If
     * the mouse is pressed in a handle, an internal flag
     * is set to indicate that the operation is resizing
     * the shape. It stores internally the point pressed
     * and makes it available via getCurrPoint().
     * @param p point where the mouse was pressed
     */
    public void grabbed(Point p)
    {
        lastPt = p;
        resizingShape = inHandle(p) != -1;
    }

    /**
     * Method called when the mouse is being dragged
     * either moving the shape or resizing the shape.
     * If the originating mouse down was inside of 
     * a handle point, then this method will call
     * updateSize, otherwise it calls updateLocation.
     * It stores internally the location of the mouse
     * and makes it available via getCurrPoint().
     * @param dx delta x for resizing the shape.
     * @param dy delta y for resizing the shape.
     */
    public void dragging(int dx, int dy)
    {
        lastPt = new Point(lastPt.x + dx, lastPt.y + dy);
        if (isBeingResized())
            updateSize(dx, dy);
        else
            updateLocation(dx, dy);
    }

    /**
     * Method called when the mouse is released. Sets
     * internal variables to indicate that the mouse
     * action is finished.
     * @param p point where the mouse was released
     */
    public void released(Point p)
    {
        resizingShape = false;
        lastPt = null;
    }

    /**
     * Abstract method that moves the shape to a new 
     * location indicated by x,y. It should update all 
     * control and handle points.
     * @param x coordinate for the shape
     * @param y coordinate for the shape
     */
    public abstract void moveTo(int x, int y);

    /**
     * Abstract method that resizes the shape as a result
     * of dragging on the handle point(s).
     * @param dx delta x for resizing the shape.
     * @param dy delta y for resizing the shape.
     */
    public abstract void updateSize(int dx, int dy);

    /**
     * Abstract method that moves (offset) the shape to a
     * new location indicated by dx,dy. It should update
     * all control and handle points.
     * @param dx delta x for the shape
     * @param dy delta y for the shape
     */
    public abstract void updateLocation(int dx, int dy);


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