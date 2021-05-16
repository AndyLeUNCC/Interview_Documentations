package com.uncc.midterm;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

/**
 * File Name:MainActivity.java
 * Full Name of the student:
 * Andy Le
 */

public class MainActivity extends AppCompatActivity implements LoginFragment.LoginFragmentListener,
        NewAccountFragment.NewAccountFragmentListener,
        ForumsFragment.ForumsFragmentListener, NewForumFragment.NewForumFragmentListener, ForumDetailFragment.ForumDetailFragmentListener {

    DataServices.Account account;
    String token = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        getSupportFragmentManager().beginTransaction()
                .add(R.id.containerView, new LoginFragment())
                .commit();

    }

    @Override
    public void returnedAuthResponeObject(DataServices.AuthResponse authResponse) {
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.containerView,  ForumsFragment.newInstance(authResponse), "ForumsFragment")
                .commit();
    }

    @Override
    public void createNewAccountFragment() {
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.containerView, NewAccountFragment.newInstance())
                .commit();
    }

    @Override
    public void replaceWithLoginFragment() {
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.containerView, new LoginFragment())
                .commit();

    }

    @Override
    public void createNewForumFragment(DataServices.AuthResponse authResponse) {
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.containerView, NewForumFragment.newInstance(authResponse), "NewForumFragment")
                .addToBackStack(null)
                .commit();
    }

    @Override
    public void replaceWithForumDetailFragment(DataServices.AuthResponse authResponse, DataServices.Forum forum) {
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.containerView, ForumDetailFragment.newInstance(authResponse,forum), "ForumDetailFragment")
                .addToBackStack(null)
                .commit();
    }

    @Override
    public void replaceWithForumsFragment(DataServices.AuthResponse authResponse) {
        getSupportFragmentManager().beginTransaction()
                .replace(R.id.containerView,  ForumsFragment.newInstance(authResponse), "ForumsFragment")
                .commit();
    }

    @Override
    public void backToForumsFragment(DataServices.Forum forum) {
        ForumsFragment fragment = (ForumsFragment) getSupportFragmentManager().findFragmentByTag("ForumsFragment");

        if(fragment != null && forum != null){
            //fragment.setSort(sortBy, sortDirection);
            fragment.addNewForum(forum);
        }
        getSupportFragmentManager().popBackStack();
    }


}