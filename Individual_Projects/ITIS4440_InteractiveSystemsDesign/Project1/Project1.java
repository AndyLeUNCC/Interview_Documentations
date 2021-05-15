package uncc.project1;



/**
 * Project1.java
 * ITIS 4440 User Interface Design and Implementation
 * @author Andy Le, UNC Charlotte
 *
 * Requires the SFramework
 * Compile: javac Project1.java
 * Run: java Project1
 *
 */
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.event.MouseEvent;

import javax.swing.JMenu;
import javax.swing.JMenuItem;

/**
 * This class will be built a small graphical user interface and
 * implement some simple actions in menus.
 */
public class Project1 extends SWindow {
    static final int ORIGINAL_X  = 15;
    static final int ORIGINAL_Y  = 15;
    static final int NUDGE_RIGHT = 50;
    static final int NUDGE_LEFT  = 50;
    private int      size        = 50;
    private Point    topLeft;

    /**
     * Constructor for Project1
     */
    public Project1() {
        super("Project1");
    }

    /**
     * Open action, called “Nudge Left” by changes the topLeft point (offset) by -50 points
     * in the x direction
     */
    public void changeNudgeLeft() {
        topLeft.setLocation((int) topLeft.getX() - NUDGE_LEFT, (int) topLeft.getY());
        repaint();
    }

    /**
     * Open action, called “Nudge Right” by changes the topLeft point (offset) by 50 points
     * in the x direction
     */
    public void changeNudgeRight() {
        topLeft.setLocation((int) topLeft.getX() + NUDGE_RIGHT, (int) topLeft.getY());
        repaint();
    }

    /**
     * Open action, sets the topLeft back to its original values
     */
    public void changeReset() {
        topLeft.setLocation(ORIGINAL_X, ORIGINAL_Y);
        repaint();
    }

    /**
     * Close action, closes the current window
     */
    public void close() {
        closeWindow();
    }

    /**
     * Initialize this window by adding an action to the
     * File:Open, File:Close, and File:Quit
     */
    public void init() {

        // initialize topLeft to 15,15
        topLeft = new Point(ORIGINAL_X, ORIGINAL_Y);

        // adding actions to menu items
        addAction("File", "New", () -> openNewWindow());
        addAction("File", "Close", () -> close());
        addAction("Project1", "Quit", () -> quit());

        // adding menu items to existing menus
        JMenu edit = getEditMenu();

        edit.addSeparator();
        installMenuItem(edit, new JMenuItem("Nudge Right"), () -> changeNudgeRight());
        installMenuItem(edit, new JMenuItem("Nudge Left"), () -> changeNudgeLeft());
        installMenuItem(edit, new JMenuItem("Reset"), () -> changeReset());
    }

    // main program that runs this project
    public static void main(String[] args) {
        new Project1();
        
    }

    /**
     * This method is to capture the mouse clicked
     * and store the point of the mouse in the topLeft instance variable.
     * To update the screen by call repaint().
     */
    public void mouseClicked(MouseEvent e) {
        topLeft = e.getPoint();
        repaint();
        setStatus("mouseClicked(" + (int) e.getX() + "," + (int) e.getY() + ")", 2);
    }

    /**
     *  This method would make the object follow the mouse when dragging (click and drag).
     */
    public void mouseDragged(MouseEvent e) {
        topLeft = e.getPoint();
        repaint();
        setStatus("mouseGragged(" + (int) e.getX() + "," + (int) e.getY() + ")", 2);
    }

    /**
     * Open action, creates a new window
     */
    public void openNewWindow() {

        // setStatus("You selected File:Open");
        new Project1();
    }

    /**
     * Paints the canvas area by just drawing
     * a square at topLeft and of size 50 and
     * draw a circle (oval) at topLeft of radius 50.
     * @param Graphics2D environment
     */
    void paintCanvas(Graphics2D g) {
        g.drawRect((int) topLeft.getX(), (int) topLeft.getY(), size, size);
        g.drawOval((int) topLeft.getX(), (int) topLeft.getY(), size, size);
    }

    /**
     * Quit action, terminates the program
     */
    public void quit() {
        System.exit(0);
    }

    /**
     * This method return the topLeft variable
     */
    public Point getTopLeft() {
        return topLeft;
    }
}
