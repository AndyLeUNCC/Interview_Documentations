package com.uncc.midterm;

import android.annotation.SuppressLint;
import android.app.Activity;
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

import java.util.Objects;
/**
 * File Name:LoginFragment.java
 * Full Name of the student:
 * Andy Le
 */

/**
 * Login fragment let user login by the valid email and password.
 */
public class LoginFragment extends Fragment {
    Button btnLogin, btnCreateNewAccount;
    EditText edtEmail, edtPassword;
    DataServices.AuthResponse authResponse;
    LoginFragmentListener mListener;
    String Tag = "Test";

    public LoginFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.d(Tag, "onCreate");

    }

    @SuppressLint("SetTextI18n")
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        Objects.requireNonNull(getActivity()).setTitle("Login");
        Log.d(Tag, "onCreateView");

        // Inflate the layout for this fragment
        View loginView = inflater.inflate(R.layout.fragment_login, container, false);
        edtEmail = loginView.findViewById(R.id.edtEmailAddress);
        edtPassword = loginView.findViewById(R.id.edtPassword);
        edtEmail.setText("b@b.com");
        edtPassword.setText("test123");

        /**
         * Clicking “Login” button, if all the inputs are not empty, you should attempt to login
         * the user by calling the DataServices.login function.
         *
         */
        btnLogin = loginView.findViewById(R.id.btnLogin);
        btnLogin.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                //If there is missing input, show a Toast indicating missing input.
                if (validate()) {
                    String email = edtEmail.getText().toString();
                    String passWord = edtPassword.getText().toString();
                    new LoginAsyncTask().execute(email, passWord);

                }

            }
        });


        btnCreateNewAccount = loginView.findViewById(R.id.btnRegister);


        /**
         * Clicking the “Create New Account” should replace this fragment with the Register
         * Fragment.
         */
        btnCreateNewAccount.setOnClickListener(v -> {
            //Toast.makeText(getActivity(), "Fragment Login-click on Create New Account button", Toast.LENGTH_SHORT).show();
            mListener.createNewAccountFragment();
        });

        return loginView;
    }


    interface LoginFragmentListener {
        void returnedAuthResponeObject(DataServices.AuthResponse authResponse);
        void createNewAccountFragment();
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        mListener = (LoginFragmentListener) context;
        Log.d(Tag, "onAttach: ");
    }

    /**
     * This class should start the execution of a
     * background AsyncTask
     */
    private class LoginAsyncTask extends AsyncTask<Object, String, AsyncTaskResult<DataServices.AuthResponse>> {

        @Override
        protected void onPreExecute() {

            //lock UI components on fragment
            buttonLocker(false);

        }

        @Override
        protected AsyncTaskResult<DataServices.AuthResponse> doInBackground(Object... params) {
            String email, password;

            AsyncTaskResult<DataServices.AuthResponse> asyncTaskResult = null;
            email = (String) params[0];
            password = (String) params[1];
            DataServices.RequestException exception = null;
            try {
                authResponse = DataServices.login(email, password);
                if (authResponse != null) {
                    //account = DataServices.getAccount(token);
                    asyncTaskResult = new AsyncTaskResult<>(authResponse);
                }

            } catch (DataServices.RequestException anyError) {
                return new AsyncTaskResult<>(anyError);
            }

            return asyncTaskResult;
        }

        protected void onPostExecute(AsyncTaskResult<DataServices.AuthResponse> result) {
            // return a string token if login successful
            if (result.getError() != null) {
                // error handling here
                Toast.makeText(getActivity(), result.getError().getLocalizedMessage(), Toast.LENGTH_SHORT).show();

            } else if (isCancelled()) {
                // cancel handling here
            } else {
                authResponse = result.getResult();
                mListener.returnedAuthResponeObject(authResponse);
            }

            //unlock UI components on fragment
            buttonLocker(true);


        }
    }

    /**
     * Locks or Unlocks button
     *
     * @param lock lock or unlock
     */
    public void buttonLocker(Boolean lock) {
        btnLogin.setEnabled(lock);
        btnCreateNewAccount.setEnabled(lock);
    }

    /**
     * This method is used to check if an input is valid, if it is not it will send a Toast
     * about what is causing the error
     *
     * @return Returns a Boolean of whether the values for account are valid or not
     */
    public Boolean validate() {
        //Declares the strings
        String email = edtEmail.getText().toString();
        String passWord = edtPassword.getText().toString();

        //Checks email
        if (email.replaceAll("\\s", "").isEmpty()) {
            Toast.makeText(getActivity(), getString(R.string.msgEmailErrorEmpty), Toast.LENGTH_SHORT).show();
            return false;
        }

        //Checks password
        if (passWord.isEmpty()) {
            Toast.makeText(getActivity(), getString(R.string.msgPasswordErrorEmpty), Toast.LENGTH_SHORT).show();
            return false;
        }


        return true;
    }
}