package uncc.project2;

/**
 * RObject.java 
 * ITIS 4440/6370 User Interface Design and Implementation
 * @author manuel a. perez-quinones, UNC Charlotte (formerly Virginia Tech)
 * CS 5774 User Interface Software
 * copyright manuel a. perez-quinones, virginia tech
 * see full copyright notice at end of file
 *
 * Sample program demostrating pick correlation of mouse interactions.
 * This class represents a [R]ectangular object on the screen.
 *
 * Comipile: javac Pick.java
 * Run:      java Pick [name of window | 1 | 2 | 3]
 */

import java.awt.*;

public class RObject {
  int x, y;
  Color c;
	int g;
  final int size = 80;

  RObject(int x, int y, Color c, int g) {
    this.x = x;
    this.y = y;
    this.c = c;
		this.g = g;
  }
  
  void draw(Graphics g) {
    g.setColor(c);
    g.fillRect(x, y, size, size);
  }

  Point center() {
    return new Point(x + size/2, y + size/2);
  }

  boolean containsPt(Point pt) {
    return pt.x > x && pt.x < x+size && pt.y > y && pt.y < y+size;
  }

  boolean withinGravity(Point pt) {
    return pt.x > x - g && pt.x < x+size+g && pt.y > y-g && pt.y < y+size+g;
  }

  Rectangle boundingBox() {
    return new Rectangle(x, y, x+size, y+size);
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
 *
 */
