package com.uncc.midterm;
/**
 * File Name:RegisterAccountFragment.java
 * Full Name of the student:
 * Andy Le
 */

import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.fragment.app.Fragment;

/**
 * NewForumFragment fragment
 * This fragment should allow a user to create a new forum.
 */
public class NewForumFragment extends Fragment {
    Button btnSubmit, btnCancel;
    EditText edtForumTitle, edtForumDescription;
    String token;

    DataServices.AuthResponse authResponse;

    private static final String ARG_PARAM_TOKEN = "TOKEN";
    String Tag = "NewForumFragment";



    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @return A new instance of fragment NewForumFragment.
     */
    public static NewForumFragment newInstance(DataServices.AuthResponse authResponse) {
        NewForumFragment fragment = new NewForumFragment();
        Bundle args = new Bundle();
        args.putSerializable("ARG_PARAM_AUTH", authResponse);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        mListener = (NewForumFragmentListener) context;
        Log.d(Tag, "onAttach: ");
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getArguments() != null) {
            authResponse = (DataServices.AuthResponse) getArguments().getSerializable("ARG_PARAM_AUTH");
            token = authResponse.getToken();
        }
        Log.d(Tag, "onCreate: ");


    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        getActivity().setTitle("New Forum");
        Log.d(Tag, "onCreateView: ");

        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_new_forum, container, false);

        btnSubmit = view.findViewById(R.id.btnSubmit);
        btnCancel = view.findViewById(R.id.btnCancel);

        edtForumTitle = view.findViewById(R.id.edtForumTitle);
        edtForumDescription = view.findViewById(R.id.edtForumDescription);

        btnSubmit.setOnClickListener(v -> {
            //Toast.makeText(getActivity(), "Fragment Login-click on login button", Toast.LENGTH_SHORT).show();
            if (validate()) {
                String forumTitle = edtForumTitle.getText().toString();
                String forumDescription = edtForumDescription.getText().toString();

                new RegisterAsyncTask().execute(token,forumTitle, forumDescription);

            }

        });


        btnCancel.setOnClickListener(new View.OnClickListener() {
            /**
             * Clicking “Cancel” should replace this fragment with the Login Fragment.
             */
            @Override
            public void onClick(View v) {
                mListener.backToForumsFragment(null);
            }
        });

        return view;
    }
    NewForumFragmentListener mListener;
    interface NewForumFragmentListener {
        void backToForumsFragment(DataServices.Forum forum);
    }

    /**
     * Locks or Unlocks button
     *
     * @param lock lock or unlock
     */
    public void buttonLocker(Boolean lock) {
        btnCancel.setEnabled(lock);
        btnSubmit.setEnabled(lock);
    }

    /**
     * This method is used to check if an input is valid, if it is not it will send a Toast
     * about what is causing the error
     *
     * @return Returns a Boolean of whether the values for account are valid or not
     */
    public Boolean validate() {
        //Declares the strings
        String forumTitle = edtForumTitle.getText().toString();
        String forumDescription = edtForumDescription.getText().toString();

        //Checks forum title
        if (forumTitle.replaceAll("\\s", "").isEmpty()) {
            Toast.makeText(getActivity(), getString(R.string.msgForumTitleErrorEmpty), Toast.LENGTH_SHORT).show();
            return false;
        }

        //Checks forum description
        if (forumDescription.isEmpty()) {
            Toast.makeText(getActivity(), getString(R.string.msgForumDescriptionErrorEmpty), Toast.LENGTH_SHORT).show();
            return false;
        }

        return true;
    }

    /**
     * This class should start the execution of a
     * background AsyncTask
     */
    private class RegisterAsyncTask extends AsyncTask<Object, String, AsyncTaskResult<DataServices.Forum>> {

        @Override
        protected void onPreExecute() {

            //lock UI components on fragment
            buttonLocker(false);

        }

        @Override
        protected AsyncTaskResult<DataServices.Forum> doInBackground(Object... params) {
            String token, title, description;

            AsyncTaskResult<DataServices.Forum> asyncTaskResult = null;
            token = (String) params[0];
            title = (String) params[1];
            description = (String) params[2];
            DataServices.RequestException exception = null;
            DataServices.Forum forum;
            try {
                forum = DataServices.createForum(token, title, description);
                if (forum != null) {
                    //account = DataServices.getAccount(token);
                    asyncTaskResult = new AsyncTaskResult<>(forum);
                }
            } catch (DataServices.RequestException anyError) {
                return new AsyncTaskResult<>(anyError);
            }

            return asyncTaskResult;
        }

        protected void onPostExecute(AsyncTaskResult<DataServices.Forum> result) {
            // return a string token if login successful
            if (result.getError() != null) {
                // error handling here
                Toast.makeText(getActivity(), result.getError().getLocalizedMessage(), Toast.LENGTH_SHORT).show();

            } else if (isCancelled()) {
                // cancel handling here
            } else {
                DataServices.Forum forum = result.getResult();
                mListener.backToForumsFragment(forum);

            }

            //unlock UI components on fragment
            buttonLocker(true);

        }

    }

}