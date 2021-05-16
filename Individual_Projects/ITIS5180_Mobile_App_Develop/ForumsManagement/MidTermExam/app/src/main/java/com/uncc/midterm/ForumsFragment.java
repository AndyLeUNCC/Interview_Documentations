package com.uncc.midterm;
/**
 * File Name:AppCategoriesFragment.java
 * Full Name of the student:
 * Andy Le
 */

import android.content.Context;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;


/**
 * A simple {@link Fragment} subclass.
 * Use the {@link ForumsFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ForumsFragment extends Fragment {

    ForumsFragmentListener mListener;
    Button btnLogOut,btnNewForum;
    LinearLayoutManager layoutManager;

    RecyclerView recyclerView;
    ArrayList<DataServices.Forum> forumList = new ArrayList<>();
    ForumsRecyclerViewAdapter adapter;

    private DataServices.Account account;
    private String token;
    private Long forumId;
    private DataServices.AuthResponse authResponse;

    String strDeleteResult = "";
    String strLike = "";
    String Tag ="ForumsFragment";

    DataServices.Forum newForum;
    public ForumsFragment(DataServices.AuthResponse authResponse) {
        // Required empty public constructor

    }

    public void addNewForum(DataServices.Forum forum) {
        this.newForum = forum;
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param authResponse This object hold the information of an account.
     * @return A new instance of fragment AppCategoriesFragment.
     */
    public static ForumsFragment newInstance(DataServices.AuthResponse authResponse) {
        ForumsFragment fragment = new ForumsFragment(authResponse);
        Bundle args = new Bundle();
        args.putSerializable("ARG_PARAM_AUTH", authResponse);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        mListener = (ForumsFragmentListener) context;
        Log.d(Tag, "onAttach: ");
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            authResponse = (DataServices.AuthResponse) getArguments().getSerializable("ARG_PARAM_AUTH");
            account = (DataServices.Account) authResponse.getAccount();
            token = authResponse.getToken();
        }
        Log.d(Tag, "onCreate");

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        getActivity().setTitle("Forums");
        Log.d(Tag, "onCreateView");

        View view = inflater.inflate(R.layout.fragment_forums, container, false);

        //mapping components on view and show data from account variable.
        btnLogOut = view.findViewById(R.id.btnLogOut);
        btnNewForum = view.findViewById(R.id.btnNewForum);
        recyclerView = view.findViewById(R.id.recyclerViewForums);
        layoutManager = new LinearLayoutManager(getContext());

        recyclerView.setLayoutManager(layoutManager);
        /**
         * Gets the account for DataServices and updates the greeting with it
         */
        new ForumsAsyncTask().execute(token);

        btnLogOut.setOnClickListener(v -> {
            //replace this fragment with the Login Fragment
            mListener.replaceWithLoginFragment();
        });

        btnNewForum.setOnClickListener(v -> {
            //replace this fragment with the Login Fragment
            mListener.createNewForumFragment(authResponse);
        });

        return view;
    }

    interface ForumsFragmentListener {
        void replaceWithLoginFragment();
        void createNewForumFragment(DataServices.AuthResponse authResponse);
        void replaceWithForumDetailFragment(DataServices.AuthResponse authResponse, DataServices.Forum forum);

    }

    public class ForumsRecyclerViewAdapter extends RecyclerView.Adapter<ForumsRecyclerViewAdapter.ViewForumHolder> {
        ArrayList<DataServices.Forum> forumList;
        private final Context context;
        DataServices.AuthResponse authResponse;
        String token;
        Long forumId;

        public ForumsRecyclerViewAdapter(Context context, ArrayList<DataServices.Forum> forumList, DataServices.AuthResponse authResponse){
            this.context = context;
            this.forumList = forumList;
            this.authResponse = authResponse;
            this.token = authResponse.getToken();
        }

        @Override
        public ForumsRecyclerViewAdapter.ViewForumHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.list_view_forum_comments, parent, false);
            ForumsRecyclerViewAdapter.ViewForumHolder vh = new ForumsRecyclerViewAdapter.ViewForumHolder(view);
            return vh;
        }

        @RequiresApi(api = Build.VERSION_CODES.O)
        @Override
        public void onBindViewHolder(@NonNull ForumsRecyclerViewAdapter.ViewForumHolder holder, int position) {
            DataServices.Forum forum = forumList.get(position);
            holder.setupRowItem(authResponse,forum);
        }

        @Override
        public int getItemCount() {
            return forumList.size();
        }

        public class ViewForumHolder extends RecyclerView.ViewHolder {
            private DataServices.Forum forum;
            private TextView txtTitle, txtNameForumCreator, txtForumDescription, txtNumberForumLikes, txtDateTimeCreated,textViewMore;
            ImageView imageViewDelete, imageViewLike;

            Long forumId;
            boolean like = false;



            public ViewForumHolder(View view) {
                super(view);

                txtTitle = view.findViewById(R.id.txtForumTitle);
                txtNameForumCreator = view.findViewById(R.id.txtNameForumCreator);
                txtForumDescription = view.findViewById(R.id.txtForumDescription);
                txtNumberForumLikes = view.findViewById(R.id.txtNumberForumLikes);
                txtDateTimeCreated = view.findViewById(R.id.txtDateTimeCreated);
                imageViewDelete = view.findViewById(R.id.imageViewDelete);
                imageViewLike = view.findViewById(R.id.imageViewLike);
                textViewMore = view.findViewById(R.id.textViewMore);


                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Log.d(Tag, "onClick: Forum Detail " + txtTitle.getText().toString() );
                        mListener.replaceWithForumDetailFragment(authResponse, forum);
                    }
                });

                view.findViewById(R.id.imageViewDelete).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Log.d(Tag, "onClick: Delete " + txtTitle.getText().toString() );
                        //mListener.sortSelected(mLabel, "DESC");
                        new DeleteForumAsyncTask().execute(token, forumId);

                    }
                });

                view.findViewById(R.id.imageViewLike).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        //mListener.sortSelected(mLabel, "ASC");
                        if (like) {
                            like = false;
                            imageViewLike.setImageResource(R.drawable.like_not_favorite);
                            Log.d(Tag, "onClick: UnLike " + txtTitle.getText().toString() );

                        } else{
                            like = true;
                            imageViewLike.setImageResource(R.drawable.like_favorite);
                            Log.d(Tag, "onClick: Like " + txtTitle.getText().toString() );

                        }


                        new LikeOrDislikeForumAsyncTask().execute(token, forumId, like);


                    }
                });
            }

            @RequiresApi(api = Build.VERSION_CODES.O)
            public void setupRowItem(DataServices.AuthResponse authResponse, DataServices.Forum forum){

                this.forum = forum;
                forumId = forum.getForumId();
                String forumCreator = forum.getCreatedBy().getName();
                txtTitle.setText(forum.getTitle());

                txtNameForumCreator.setText(forumCreator);
                String forumDes = forum.getDescription();
                if (forumDes.length() > 200) {
                    Log.d(Tag,"more than 200 characters");
                    String forumDesLess = forumDes.substring(0,199);
                    txtForumDescription.setText(forumDesLess);
                    textViewMore.setVisibility(View.VISIBLE);

                } else {
                    txtForumDescription.setText(forumDes);
                    textViewMore.setVisibility(View.INVISIBLE);


                }
                //Log.d("demo", "Number Like/Dislike " + forum.getLikedBy().size());

                txtNumberForumLikes.setText(forum.getLikedBy().size() + " Likes |");
                SimpleDateFormat myFormatObj = new SimpleDateFormat("dd-MM-yyyy HH:mm a");

                String formattedDate = myFormatObj.format(forum.getCreatedAt());
                txtDateTimeCreated.setText(formattedDate);

                //if the currently logged user is people created this forum then visible Delete icon
                if(authResponse.getAccount().uid == forum.getCreatedBy().uid){
                    imageViewDelete.setVisibility(View.VISIBLE);
                } else{
                    imageViewDelete.setVisibility(View.INVISIBLE);
                }

                /**
                 * The like or unlike indicator which are represented by un-filled heart icon and filled
                 * heart respectively. Each Forum object contains a set of user accounts that have
                 * liked the forum. If the currently logged in user has liked a forum then the filled
                 * heart should be displayed, and otherwise the un-filled heart icon should be
                 * displayed for that forum list item.
                 */
                HashSet<DataServices.Account> accounts = forum.getLikedBy();
                for (DataServices.Account account: accounts) {
                    if (account.uid == authResponse.getAccount().uid){
                        like = true;
                        break;
                    }
                }
                if (like) {
                    imageViewLike.setImageResource(R.drawable.like_favorite);
                } else {
                    imageViewLike.setImageResource(R.drawable.like_not_favorite);
                }



            }
        }


    }

    /**
     * This class should start the execution in the background
     */
    private class LikeOrDislikeForumAsyncTask extends AsyncTask<Object, String, AsyncTaskResult<String>> {

        @Override
        protected AsyncTaskResult<String> doInBackground(Object... params) {
            AsyncTaskResult<String> asyncTaskResult = null;
            String token = (String) params[0];
            Long forumId = (Long) params[1];
            Boolean like = (Boolean) params[2];


            DataServices.RequestException exception = null;
            try {
                if (token != null && forumId != null) {
                    if (like) {
                        DataServices.likeForum(token,forumId);
                        asyncTaskResult = new AsyncTaskResult<>("like");

                    } else {
                        DataServices.unLikeForum(token,forumId);
                        asyncTaskResult = new AsyncTaskResult<>("unLike");

                    }
                }
            } catch (DataServices.RequestException anyError) {
                return new AsyncTaskResult<>(anyError);
            }

            //publishProgress(token);
            return asyncTaskResult;
        }

        protected void onPostExecute(AsyncTaskResult<String> result) {
            // return a string token if login successful
            if (result.getError() != null) {
                // error handling here
                Toast.makeText(getActivity(), result.getError().getLocalizedMessage(), Toast.LENGTH_SHORT).show();

            } else if (isCancelled()) {
                // cancel handling here
            } else {
                strLike = result.getResult();

                //calling the DataServices.getAllForums() method in the background and
                //should refresh the RecyclerView rows to reflect the deletion
                new ForumsAsyncTask().execute(token);

            }

            //unlock UI components on fragment
            buttonLocker(true);

        }
    }

    /**
     * This class should start the execution in the background
     */
    private class DeleteForumAsyncTask extends AsyncTask<Object, String, AsyncTaskResult<String>> {

        @Override
        protected AsyncTaskResult<String> doInBackground(Object... params) {
            AsyncTaskResult<String> asyncTaskResult = null;
            String token = (String) params[0];
            Long forumId = (Long) params[1];

            DataServices.RequestException exception = null;
            try {
                if (token != null && forumId != null) {
                    DataServices.deleteForum(token,forumId);
                    asyncTaskResult = new AsyncTaskResult<>("");
                }
            } catch (DataServices.RequestException anyError) {
                return new AsyncTaskResult<>(anyError);
            }

            //publishProgress(token);
            return asyncTaskResult;
        }

        protected void onPostExecute(AsyncTaskResult<String> result) {
            // return a string token if login successful
            if (result.getError() != null) {
                // error handling here
                Toast.makeText(getActivity(), result.getError().getLocalizedMessage(), Toast.LENGTH_SHORT).show();

            } else if (isCancelled()) {
                // cancel handling here
            } else {
                strDeleteResult = result.getResult();
                if (strDeleteResult.equals("")) {
                    //calling the DataServices.getAllForums() method in the background and
                    //should refresh the RecyclerView rows to reflect the deletion
                    new ForumsAsyncTask().execute(token);

                }


            }

            //unlock UI components on fragment
            buttonLocker(true);

        }
    }

    /**
     * This class should start the execution in the background
     */
    private class ForumsAsyncTask extends AsyncTask<Object, String, AsyncTaskResult<ArrayList>> {

        @Override
        protected AsyncTaskResult<ArrayList> doInBackground(Object... params) {
            AsyncTaskResult<ArrayList> asyncTaskResult = null;
            String token = (String) params[0];
            DataServices.RequestException exception = null;
            try {
                if (token != null) {
                    ArrayList<DataServices.Forum> data = DataServices.getAllForums(token);
                    asyncTaskResult = new AsyncTaskResult<ArrayList>(data);
                }
            } catch (DataServices.RequestException anyError) {
                return new AsyncTaskResult<>(anyError);
            }

            //publishProgress(token);
            return asyncTaskResult;
        }

        protected void onPostExecute(AsyncTaskResult<ArrayList> result) {
            // return a string token if login successful
            if (result.getError() != null) {
                // error handling here
                Toast.makeText(getActivity(), result.getError().getLocalizedMessage(), Toast.LENGTH_SHORT).show();

            } else if (isCancelled()) {
                // cancel handling here
            } else {
                forumList = result.getResult();
                Log.d(Tag, "forumList Size: " + forumList.size());

                DividerItemDecoration dividerItemDecoration = new DividerItemDecoration(recyclerView.getContext(),
                        layoutManager.getOrientation());
                recyclerView.addItemDecoration(dividerItemDecoration);
                adapter = new ForumsRecyclerViewAdapter(getContext(), forumList, authResponse);
                recyclerView.setAdapter(adapter);

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
        btnLogOut.setEnabled(lock);
        btnNewForum.setEnabled(lock);
    }





}