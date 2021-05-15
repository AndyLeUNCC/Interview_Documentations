package uncc.project2;

/**
 * File: SCircle.java
 * ITIS 4440 User Interface Design and Implementation
 * See copyright at end of file
 * @author manuel a perez-quinones
 * @version 1.1
 *
 * Requires the SFramework
 * Compile: javac SCircle.java
 */

import java.awt.geom.*;
import java.awt.*;

public class SCircle extends SShape 
{

    /**
     * Constructor for circle part of SShape classes. It creates
     * two control points, one for the center of the circle and
     * another one for the radius that is at angle 0. It also
     * creates a handle for resizing the circle. The handle is
     * the same as the 2nd control point.
     * @param x coordinate for the center of the circle.
     * @param y coordinate for the center of the circle.
     * @param r is the radius for the circle.
     */
    public SCircle(int x, int y, int r)
    {
        super();
        addControl(x, y);    // [0]
        addControl(x+r, y);  // [1]
        addHandle(getControl(1));
    }

    /**
     * Calculates the length of the radius by computing
     * the distance between the two control points defining
     * the circle.
     * @return length of the radius
     */
    private int getRadius()
    {
        assert(getControl(0) != null);
        assert(getControl(1) != null);
        return (int)getControl(0).distance(getControl(1));
    }
    /**
     * Move the circle to a new location indicated by x,y. It
     * updates all control and handle points.
     * @param x coordinate for new the center of circle.
     * @param y coordinate for new the center of the circle.
     */
    @Override
    public void  moveTo(int x, int y)
    {
        int r = getRadius();
        // center.setLocation(x, y);
        setControl(0, x, y);
        setControl(1, x+r, y);
        setHandle(0, getControl(1));
    }

    /**
     * Move (offset) the circle to a new location indicated 
     * by dx,dy. It updates all control and handle points.
     * @param dx delta x for new the center of the circle.
     * @param dy delta y for new the center of the circle.
     */
    @Override
    public void  updateLocation(int dx, int dy)
    {
        int r = getRadius();
        setControl(0, getControl(0).x + dx, getControl(0).y + dy);
        setControl(1, getControl(0).x + r, getControl(0).y);
        setHandle(0, getControl(1));
    }

    /**
     * Resize the circle as a result of dragging on the
     * handle point. The resize changes the 2nd (index 1)
     * control point and updates the handle to the same
     * location.
     * @param dx delta x for resizing the circle.
     * @param dy delta y for resizing the circle.
     */
    @Override
    public void updateSize(int dx, int dy)
    {
        setControl(1, getCurrPoint());
        setHandle(0, getControl(1));
    }

    /**
     * Mouse was released at p after either moving the circle or
     * resizing it. This calls the inherited method release() and
     * then updates location of the handle and control point 1.
     * @param p mouse location where mouse was released.
     */
    @Override
    public void released(Point p)
    {
        super.released(p);
        int r = getRadius();
        setControl(1, getControl(0).x + r, getControl(0).y);
        setHandle(0, getControl(1));
    }


    /**
     * Draw this circle using the graphics object g. The drawing
     * handles numerous things. If the shape is filled, it uses
     * the fillColor to paint the fill the circle. If the shape
     * is selected a radius is draw from the center to the edge
     * at angle 0 and a handle is drawn. The handle drawing calls
     * drawHandles() inherited from SShape. It does different
     * drawing depending on whether the shape is being resized
     * or not. If being resized, the radius is draw to the location
     * of the mouse (instead of at angle 0).
     * @param g Graphics2D
     */
    @Override
    public void draw(Graphics2D g)
    {
        int r = getRadius();

        if (isFilled()) {
            g.setColor(getFillColor());
            g.fillOval(getControl(0).x-r, 
                getControl(0).y-r, getWidth(), getHeight());
        }

        g.setColor(getBorderColor());
        g.drawOval(getControl(0).x-r, 
            getControl(0).y-r, getWidth(), getHeight());

        if (isSelected()) {
            if (isBeingResized()) {
                g.drawLine(getControl(0).x, getControl(0).y, 
                    getCurrPoint().x, getCurrPoint().y);
                g.setColor(Color.BLACK);
                drawHandles(g);
            }
            else {
                g.drawLine(getControl(0).x, getControl(0).y, 
                    getControl(0).x+r, getControl(0).y);
                g.setColor(Color.BLACK);
                drawHandles(g);
            }
        }
    }

    /**
     * Tests if a specified Point2D is inside the boundary of the 
     * Shape. Testing is done by checking if the distance from the
     * center (control point 0) to p is less than the distance from
     * the center (control point 0) to the handle or 2nd control point,
     * that is the radius.
     * @param p point to test if it is inside of the circle
     * @return true if p is inside of the circle, false otherwise.
     */
    @Override
    public boolean contains(Point2D p)
    {
        return p.distance(getControl(0)) < getControl(0).distance(getControl(1));
    }

    /**
     * Return the height of the circle, ie. radius * 2.
     * @return int height of the circle.
     */
    @Override
    public int getHeight()
    {
        return getRadius()*2;
    }

    /**
     * Return the width of the circle, ie. radius * 2.
     * @return int width of the circle.
     */
    @Override
    public int getWidth()
    {
        return getRadius()*2;
    }

    /**
     * Returns a rectangle that marks the bounding box of the circle. The
     * rectangle will have width and height of 2*r where r is the radius
     * of the circle.
     * @return bounding box for the circle
     */
    @Override
    public Rectangle getBounds()
    {
        int r = getRadius();
        return new Rectangle(getControl(0).x-r, getControl(0).y-r,
            getWidth(), getHeight());
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