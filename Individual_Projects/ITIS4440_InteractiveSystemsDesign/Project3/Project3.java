package uncc.project3;

/**
 * Project3.java ITIS 4440 User Interface Design and Implementation
 *
 * @author Andy Le, UNC Charlotte
 *
 * Requires the SFramework Compile: javac Project3.java Run: java Project3
 *
 */
import java.awt.*;
import java.awt.Graphics2D;
import java.awt.Point;
import java.awt.event.MouseEvent;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JMenuBar;
import java.util.ArrayList; // import the ArrayList class
import java.util.Iterator;
import java.util.Scanner;
import javax.swing.*;

/**
 * This class will be built a small graphical user interface and implement some
 * simple actions in menus.
 */
public class Project3 extends SWindow {

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
     * Constructor for Project3.
     */
    public Project3() {
        super("Project3");
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
        list.add(new SRectangle(120, 100, 80, 80));
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
        markDirty();
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
        markDirty();
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
        markDirty();
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
        markDirty();

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
        markDirty();

        repaint();
        updateMenus();
    }

    //==============================================
    //File menus group - Start
    /**
     * Open action, creates a new window.
     */
    public void openNewWindow() {

        new Project3();
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
     * This routine should return the array list where you store your shapes.
     *
     * @return ArrayList<SShape>> The array list of shapes
     */
    public ArrayList<SShape> getShapes() {
        return list;
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
        addAction("Project3", "Quit", () -> quit());

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

        // The reason for the document
        attachDocument(new SDocument() {
            /**
             * Write contents of the document to file.
             *
             * @param file File object where to write
             */
            @Override
            public void write(File file) throws IOException {
                setStatus("write(\"" + file.getAbsolutePath() + "\")");
                writeDataToTextFile(file);
                setStatus("done");
            }

            /**
             * Read contents of the document from a file.
             *
             * @param file File object from where to read
             */
            @Override
            public void read(File file) throws IOException {

                setStatus("read(\"" + file.getName() + "\")");
                readDataFromTextFile(file);
                markClean();
                repaint();
            }
        });

    }

    /**
     * This method write data of list of shapes on the window in a text file.
     *
     * @param file File object where to write
     */
    private void writeDataToTextFile(File file) throws IOException {
        FileWriter outStream = new FileWriter(file.getAbsolutePath());
        for (SShape a : list) {
            if (a instanceof SCircle) {
                outStream.write("# circle" + "\n");
            } else if (a instanceof STriangle) {
                outStream.write("# triangle" + "\n");
            } else if (a instanceof SRectangle) {
                //check a is a square then write # square
                if (a.getHeight() == a.getWidth()) {
                    outStream.write("# square" + "\n");
                } else {
                    outStream.write("# rectangle" + "\n");
                }
            } else if (a instanceof SLine) {
                outStream.write("# line" + "\n");
            }
            outStream.write(a.toString());
            outStream.write("\n");
        }

        outStream.close();

    }

    /**
     * Read contents of the document from a file.
     *
     * @param file File object from where to read
     * @throws java.io.IOException
     */
    public void readDataFromTextFile(File file) throws IOException {
        ArrayList<String> keywordList = new ArrayList<String>() {
            {
                add("border");
                add("fill");
                add("circle");
                add("rectangle");
                add("triangle");
                add("line");
            }
        };

        Scanner sc = null;
        int borderRed = 0; // r
        int borderGreen = 0; // g
        int borderBlue = 0; // b
        int fillRed = 0; // r
        int fillGreen = 0; // g
        int fillBlue = 0; // b
        setStatus("read(\"" + file.getName() + "\")");
        try {
            sc = new Scanner(file);

            while (sc.hasNextLine()) {
                String inputLine = sc.nextLine();
                System.out.println(inputLine);
                // do something with the line
                Scanner scanner = new Scanner(inputLine);
                while (scanner.hasNext()) {
                    String token = scanner.next();//#
                    if (keywordList.contains(token)) {
                        if (token.equalsIgnoreCase("border")) {
                            while (scanner.hasNext()) {
                                borderRed = scanner.nextInt(); // r
                                borderGreen = scanner.nextInt(); // g
                                borderBlue = scanner.nextInt(); // b
                            }

                        } else if (token.equalsIgnoreCase("fill")) {
                            while (scanner.hasNext()) {
                                fillRed = scanner.nextInt(); // r
                                fillGreen = scanner.nextInt(); // g
                                fillBlue = scanner.nextInt(); // b
                            }

                        } else if (token.equalsIgnoreCase("circle")) {
                            while (scanner.hasNext()) {
                                int x = scanner.nextInt();
                                int y = scanner.nextInt();
                                int r = scanner.nextInt();
                                SCircle cir = new SCircle(x, y, r);
                                cir.setFill(true, new Color(fillRed, fillGreen, fillBlue));
                                cir.setBorderColor(new Color(borderRed, borderGreen, borderBlue));
                                list.add(cir);
                            }
                        } else if (token.equalsIgnoreCase("triangle")) {
                            while (scanner.hasNext()) {
                                int x1 = scanner.nextInt();
                                int y1 = scanner.nextInt();
                                int x2 = scanner.nextInt();
                                int y2 = scanner.nextInt();
                                int x3 = scanner.nextInt();
                                int y3 = scanner.nextInt();
                                STriangle tri = new STriangle(x1, y1, x2, y2, x3, y3);
                                tri.setFill(true, new Color(fillRed, fillGreen, fillBlue));
                                tri.setBorderColor(new Color(borderRed, borderGreen, borderBlue));
                                list.add(tri);
                            }
                        } else if (token.equalsIgnoreCase("rectangle")) {
                            while (scanner.hasNext()) {
                                int x = scanner.nextInt();
                                int y = scanner.nextInt();
                                int w = scanner.nextInt();
                                int h = scanner.nextInt();
                                SRectangle rec = new SRectangle(x, y, w, h);
                                rec.setFill(true, new Color(fillRed, fillGreen, fillBlue));
                                rec.setBorderColor(new Color(borderRed, borderGreen, borderBlue));
                                list.add(rec);
                            }
                        } else if (token.equalsIgnoreCase("line")) {
                            while (scanner.hasNext()) {
                                int x1 = scanner.nextInt();
                                int y1 = scanner.nextInt();
                                int x2 = scanner.nextInt();
                                int y2 = scanner.nextInt();
                                SLine line = new SLine(x1, y1, x2, y2);
                                line.setFill(true, new Color(fillRed, fillGreen, fillBlue));
                                line.setBorderColor(new Color(borderRed, borderGreen, borderBlue));
                                list.add(line);
                            }

                        }
                    }

                }
            }

        } finally {
            if (sc != null) {
                sc.close();
            }
        }
        setStatus("read the data text file");
        markClean();
        repaint();
    }

    /**
     * main program that runs this project.
     *
     * @param args String Array
     */
    public static void main(String[] args) {
        new Project3();
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
        markDirty();
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
                if (a.contains(e.getPoint()) || (a.inHandle(e.getPoint()) != -1)) {
                    a.grabbed(e.getPoint());
                    a.select(true);

                } else {
                    a.select(false);
                }
                dragging = a;
                // save this point
                lastPt = e.getPoint();
                markDirty();
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
        markDirty();
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
            markDirty();
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
    @Override
    public void paintCanvas(Graphics2D g) {

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
