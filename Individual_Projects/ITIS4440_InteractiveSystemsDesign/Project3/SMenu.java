/**
 * File: SMenu.java
 * ITIS 4440 User Interface Design and Implementation
 * See copyright at end of file
 * @author manuel a perez-quinones
 * @version 1.5
 *
 * Annotation implementations for adding
 * actions to a menu item.
 */

import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)

/**
 * SMenu annotation for methods in the SFramework.
 * You can define methods with no parameters that
 * will be installed in menus based on an annotation.
 *
 * This example will install a menu action in the
 * File menu with item Quit that will call the
 * quitApp() method when selected.
 *
 * @SMenu(menu="File", item="Quit")
 * void quitApp() {
 *   System.exit(0);
 * }
 * The third optional parameter will insert a
 * menu separator before the menu item if set
 * to true;
 *
 * @SMenu(menu="File", item="Quit", separator=true)
 */

public @interface SMenu 
{
    public String menu();
    public String item();
    public boolean separator() default false;
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