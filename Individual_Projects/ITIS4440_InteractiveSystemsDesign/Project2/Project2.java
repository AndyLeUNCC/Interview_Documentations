package uncc.project2;

/**
 * Project2.java ITIS 4440 User Interface Design and Implementation
 *
 * @author Andy Le, UNC Charlotte
 *
 * Requires the SFramework Compile: javac Project2.java Run: java Project2
 *
 */
import java.awt.*;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.event.MouseEvent;

import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JMenuBar;
import java.util.ArrayList; // import the ArrayList class
import java.util.Iterator;
import javax.swing.*;

/**
 * This class will be built a small graphical user interface and implement some
 * simple actions in menus.
 */
public class Project2 extends SWindow {

    static final int ORIGINAL_X = 15;
    static final int ORIGINAL_Y = 15;
    static final int NUDGE_RIGHT = 50;
    static final int NUDGE_LEFT = 50;
    private Point topLeft;

    private ArrayList<SShape> list;
    private Point lastPt;
    private Color color;
    private SShape dragging = null;

    /**
     * Constructor for Project2.
     */
    public Project2() {
        super("Project2");
    }

    /**
     * Open action, called “Nudge Left” by changes the topLeft point (offset) by
     * -50 points in the x direction.
     */
    public void changeNudgeLeft() {
        topLeft.setLocation((int) topLeft.getX() - NUDGE_LEFT, (int) topLeft.getY());
        repaint();
    }

    /**
     * Open action, called “Nudge Right” by changes the topLeft point (offset)
     * by 50 points in the x direction.
     */
    public void changeNudgeRight() {
        topLeft.setLocation((int) topLeft.getX() + NUDGE_RIGHT, (int) topLeft.getY());
        repaint();
    }

    /**
     * Open action, sets the topLeft back to its original values.
     */
    public void changeReset() {
        topLeft.setLocation(ORIGINAL_X, ORIGINAL_Y);
        repaint();
    }

    /**
     * Open action, create a new circle objects.
     */
    public void createNewCircle() {
        setStatus("createNewCircle", 2);
        list.add(new SCircle(120, 130, 60));
        repaint();
        updateMenus();
        setStatus("Num shapes = " + list.size());

    }

    /**
     * Open action, create a new rectangle object.
     */
    public void createNewRectangle() {
        setStatus("createNewRectangle", 2);
        list.add(new SRectangle(120, 100, 80, 90));
        repaint();
        updateMenus();
        setStatus("Num shapes = " + list.size());

    }

    /**
     * Open action, create a new line object.
     */
    public void createNewLine() {
        setStatus("createNewLine", 2);
        list.add(new SLine(120, 100, 50, 70));
        repaint();
        updateMenus();
        setStatus("Num shapes = " + list.size());

    }

    /**
     * Open action, create a new triangle object.
     */
    public void createNewTriangle() {
        setStatus("createNewTriangle", 2);
        list.add(new STriangle(130, 130));
        repaint();
        updateMenus();
        setStatus("Num shapes = " + list.size());

    }

    /**
     * This method will update menu after other action end.
     */
    public void updateMenus() {
        enableAction("Shapes", "Delete", false);
        enableAction("Shapes", "Fill in Colors", false);
        enableAction("Shapes", "Fill in Monochrome", false);
        enableAction("Shapes", "Bring to Front", false);
        enableAction("Shapes", "Send to Back", false);
        if (list.size() > 0) {
            enableAction("Shapes", "Fill in Colors", true);
            enableAction("Shapes", "Fill in Monochrome", true);

        }
        for (SShape a : list) {
            if (a.isSelected()) {
                enableAction("Shapes", "Delete", true);
                enableAction("Shapes", "Fill", true);
                enableAction("Shapes", "Unfill", true);
                enableAction("Shapes", "Bring to Front", true);
                enableAction("Shapes", "Send to Back", true);
            }
        }

    }

    /**
     * Open action, set a fill color from a Color chooser dialog box.
     */
    public void setFillColor() {

        //setStatus("setFillColor", 2);
        // color chooser Dialog Box 
        color = JColorChooser.showDialog(null,
                "Select a color", Color.RED);
    }

    /**
     * This method will set fill color on the selected objects.
     *
     * @param color Color A color will filled the SShape selected object(s)
     */
    public void setFill() {

        //setStatus("setFill", 2);
        for (SShape a : list) {
            if (a.isSelected()) {
                if (color != null) {
                    a.setFill(true, color);
                } else {
                    a.setFill(true, Color.RED);
                }
            }
        }
        repaint();
        updateMenus();
    }

    /**
     * This method will set un-fill status on the selected objects.
     */
    public void setUnfill() {

        setStatus("setUnfill", 2);
        for (SShape a : list) {
            if (a.isSelected()) {
                a.setFill(false);
            }
        }
        repaint();
        updateMenus();
    }

    /**
     * Open action, do the delete on the selected shape(s).
     */
    public void setDelete() {

        setStatus("setDelete", 2);

        // Get an iterator.
        Iterator<SShape> ite = list.iterator();

        /* Remove the second value of the list, while iterating over its elements,
         * using the iterator's remove method. */
        while (ite.hasNext()) {
            SShape a = ite.next();
            if (a.isSelected()) {
                ite.remove();
            }
        }
        repaint();

        updateMenus();
        setStatus("Num shapes = " + list.size());

    }

    /**
     * Open action, bring the selected shape(s) to the front of all shapes.
     */
    public void bringToFront() {

        setStatus("bringToFront", 2);
        ArrayList<SShape> listFront = new ArrayList<SShape>();

        // Get an iterator.
        Iterator<SShape> ite = list.iterator();

        /* command should move an object to the end of the array. 
         * using the iterator's remove method. */
        while (ite.hasNext()) {
            SShape a = ite.next();
            if (a.isSelected()) {
                ite.remove();
                listFront.add(a);
            }
        }
        for (SShape a : listFront) {
            list.add(a);
        }
        repaint();

        updateMenus();
        setStatus("Num shapes = " + list.size());

    }

    /**
     * Open action, bring the selected shape(s) to the back of all shapes.
     */
    public void sendToBack() {

        setStatus("sendToBack", 2);
        ArrayList<SShape> listFront = new ArrayList<SShape>();

        // Get an iterator.
        Iterator<SShape> ite = list.iterator();

        /* command should move an object to the end of the array. 
         * using the iterator's remove method. */
        while (ite.hasNext()) {
            SShape a = ite.next();
            if (a.isSelected()) {
                ite.remove();
                listFront.add(a);
            }
        }
        for (SShape a : listFront) {
            list.add(0, a);
        }
        repaint();

        updateMenus();
        setStatus("Num shapes = " + list.size());
    }

    /**
     * This method will return a random Color with three different components.
     *
     * @return A random Color
     */
    private Color getRandomRGBColor() {
        int r = (int) Math.round(Math.random() * 255);
        int g = (int) Math.round(Math.random() * 255);
        int b = (int) Math.round(Math.random() * 255);

        Color col = new Color(r, g, b);
        return col;
    }

    /**
     * This method will return a random Color with only one component.
     *
     * @return A random Color
     */
    private Color getRandomColor() {
        int r = (int) Math.round(Math.random() * 255);

        Color col = new Color(r, r, r);
        return col;
    }

    /**
     * Open action, sets each shape to a different randomly selected color.
     */
    public void fillInColors() {

        setStatus("fillInColors", 2);
        for (SShape a : list) {
            Color color = getRandomRGBColor();
            a.setFill(true, color);
        }
        repaint();
        updateMenus();

    }

    /**
     * Open action, generates random monochrome colors and sets each shape to a
     * different randomly selected color.
     */
    public void fillInMonochrome() {

        setStatus("fillInMonochrome", 2);
        for (SShape a : list) {
            Color color = getRandomColor();
            a.setFill(true, color);
        }
        repaint();
        updateMenus();
    }

    //==============================================
    //File menus group - Start
    /**
     * Open action, creates a new window.
     */
    public void openNewWindow() {

        new Project2();
    }

    /**
     * Quit action, terminates the program.
     */
    public void quit() {
        System.exit(0);
    }

    /**
     * This routine should return the number of shapes in ArrayList list.
     *
     * @return int The number of shapes in list
     */
    public int numShapes() {
        return list.size();
    }

    /**
     * Close action, closes the current window.
     */
    public void close() {
        closeWindow();
    }
    //File menus group - End

    //==============================================
    /**
     * Initialize this window by adding an action to the File:Open, File:Close,
     * and File:Quit.
     */
    public void init() {
        list = new ArrayList<SShape>();

        // initialize topLeft to 15,15
        topLeft = new Point(ORIGINAL_X, ORIGINAL_Y);

        // adding actions to menu items
        addAction("File", "New", () -> openNewWindow());
        addAction("File", "Close", () -> close());
        addAction("Project2", "Quit", () -> quit());

        // adding menu items to existing menus
        JMenu edit = getEditMenu();

        edit.addSeparator();
        installMenuItem(edit, new JMenuItem("Nudge Right"), () -> changeNudgeRight());
        installMenuItem(edit, new JMenuItem("Nudge Left"), () -> changeNudgeLeft());
        installMenuItem(edit, new JMenuItem("Reset"), () -> changeReset());

        //Project 2 implementing some new menus
        JMenuBar menuBar = getMenuBar();
        JMenu shapes = new JMenu("Shapes");
        menuBar.add(shapes);
        installMenuItem(shapes, new JMenuItem("New Circle"), () -> createNewCircle());
        installMenuItem(shapes, new JMenuItem("New Rectangle"), () -> createNewRectangle());
        installMenuItem(shapes, new JMenuItem("New Line"), () -> createNewLine());
        installMenuItem(shapes, new JMenuItem("New Triangle"), () -> createNewTriangle());
        shapes.addSeparator();
        installMenuItem(shapes, new JMenuItem("Set Fill Color"), () -> setFillColor());
        shapes.addSeparator();
        installMenuItem(shapes, new JMenuItem("Fill"), () -> setFill());
        installMenuItem(shapes, new JMenuItem("Unfill"), () -> setUnfill());
        installMenuItem(shapes, new JMenuItem("Delete"), () -> setDelete());
        shapes.addSeparator();
        installMenuItem(shapes, new JMenuItem("Bring to Front"), () -> bringToFront());
        installMenuItem(shapes, new JMenuItem("Send to Back"), () -> sendToBack());
        shapes.addSeparator();
        installMenuItem(shapes, new JMenuItem("Fill in Colors"), () -> fillInColors());
        installMenuItem(shapes, new JMenuItem("Fill in Monochrome"), () -> fillInMonochrome());

        // adding actions to menu items
        updateMenus();

    }

    /**
     * main program that runs this project.
     *
     * @param args String Array
     */
    public static void main(String[] args) {
        new Project2();
    }

    /**
     * This method is to capture the mouse clicked and determine each of
     * shape(s) contain it. To update the screen by call repaint().
     *
     * @param e MouseEvent
     */
    public void mouseClicked(MouseEvent e) {

        for (SShape a : list) {
            if (a.contains(e.getPoint())) {
                a.select(true);
            } else {
                a.select(false);
            }
        }
        repaint();
        updateMenus();

    }

    /**
     * This method is to capture the mouse pressed and determine each of
     * shape(s) contain it. To update the screen by call repaint().
     *
     * @param e MouseEvent
     */
    public void mousePressed(MouseEvent e) {
        for (SShape a : list) {
            if (a.isSelected()) {
                if (a.contains(e.getPoint())
                        || (a.inHandle(e.getPoint()) != -1)) {

                    a.grabbed(e.getPoint());
                    a.select(true);

                } else {
                    a.select(false);
                }
                dragging = a;
                // save this point
                lastPt = e.getPoint();
                repaint();
                updateMenus();

            }

        }

    }

    /**
     * This method is to capture the mouse dragged and determine each of
     * shape(s) contain it. To update the screen by call repaint().
     *
     * @param e MouseEvent
     */
    public void mouseDragged(MouseEvent e) {

        if (dragging != null) {
            repaint();
            if (dragging.isSelected()) {
                int dx = (int) e.getPoint().getX() - lastPt.x;
                int dy = (int) e.getPoint().getY() - lastPt.y;
                dragging.dragging(dx, dy);

            }
        }

        lastPt = e.getPoint();
        repaint();

    }

    /**
     * This method is to capture the mouse released and determine each of
     * shape(s) contain it. To update the screen by call repaint().
     *
     * @param e MouseEvent
     */
    public void mouseReleased(MouseEvent e) {

        for (SShape a : list) {
            if (a.isSelected()) {
                a.released(e.getPoint());
            }
            // leave the object selected
            repaint();
            updateMenus();

        }
        if (dragging != null) {
            list.remove(dragging);
            list.add(dragging);
            /* puts it back at the end of the queue */

            dragging = null;
            repaint();
        }

    }

    /**
     * Paints the canvas area by just drawing a square at topLeft and of size 50
     * and draw a circle (oval) at topLeft of radius 50.
     *
     * @param g Graphics2D environment
     */
    void paintCanvas(Graphics2D g) {

        if (dragging != null) {
            dragging.draw(g);
        }

        for (SShape a : list) {
            if (a != dragging) {
                a.draw(g);
            }
        }

    }

    /**
     * This method return the topLeft variable.
     *
     * @return topLeft Point
     */
    public Point getTopLeft() {
        return topLeft;
    }
}
