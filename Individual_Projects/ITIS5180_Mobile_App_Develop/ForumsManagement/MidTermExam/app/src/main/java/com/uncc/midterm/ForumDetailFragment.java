package com.uncc.midterm;

import android.content.Context;
import android.os.AsyncTask;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
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

public class ForumDetailFragment extends Fragment {

    Button btnPost;
    EditText edtWriteComment;
    TextView txtTitle, txtForumDescription, txtNameForumCreator, txtComment;
    LinearLayoutManager layoutManager;

    RecyclerView recyclerView;
    ArrayList<DataServices.Comment> commentsofForum = new ArrayList<>();
    ForumDetailFragment.ForumDetailRecyclerViewAdapter adapter;

    private DataServices.Forum forum;
    private String token;
    private Long forumId;
    private DataServices.AuthResponse authResponse;
    String strDeleteResult = "";
    DataServices.Comment newComment;

    String Tag = "ForumDetailFragment";

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param forum This object hold the information of an forum.
     * @return A new instance of fragment AppCategoriesFragment.
     */
    public static ForumDetailFragment newInstance(DataServices.AuthResponse authResponse, DataServices.Forum forum) {

        ForumDetailFragment fragment = new ForumDetailFragment();

        Bundle args = new Bundle();
        args.putSerializable("ARG_PARAM_AUTH", authResponse);
        args.putSerializable("ARG_PARAM_FORUM", forum);

        fragment.setArguments(args);
        return fragment;
    }
    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        mListener = (ForumDetailFragmentListener) context;
        Log.d(Tag, "onAttach: ");
    }

    ForumDetailFragmentListener mListener;
    interface ForumDetailFragmentListener {

    }



    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            authResponse = (DataServices.AuthResponse) getArguments().getSerializable("ARG_PARAM_AUTH");
            forum = (DataServices.Forum) getArguments().getSerializable("ARG_PARAM_FORUM");
            token = authResponse.getToken();
            forumId = forum.getForumId();
        }
        Log.d(Tag, "onCreate: ");

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        getActivity().setTitle("Forum");
        Log.d(Tag, "onCreateView: ");

        View view = inflater.inflate(R.layout.fragment_forum_detail, container, false);

        //mapping components on view and show data from account variable.
        btnPost = view.findViewById(R.id.btnPost);
        edtWriteComment = view.findViewById(R.id.edtWriteComment);
        txtTitle = view.findViewById(R.id.txtForumTitle);
        txtNameForumCreator = view.findViewById(R.id.txtNameForumCreator);
        txtComment = view.findViewById(R.id.txtComment);
        txtForumDescription = view.findViewById(R.id.txtForumDescription);

        recyclerView = view.findViewById(R.id.recylerViewComments);

        txtTitle.setText(forum.getTitle());
        txtNameForumCreator.setText(forum.getCreatedBy().getName());
        txtForumDescription.setText(forum.getDescription());
        new CommentsOfForumAsyncTask().execute(token, forum.getForumId());
        if (commentsofForum != null) {
            txtComment.setText(commentsofForum.size() + " Comments");// get the recylerview size
        }


        layoutManager = new LinearLayoutManager(getContext());

        recyclerView.setLayoutManager(layoutManager);


        btnPost.setOnClickListener(v -> {
            //Checks name
            String comment = edtWriteComment.getText().toString();
            if (comment.replaceAll("\\s", "").isEmpty()) {
                Toast.makeText(getActivity(), "Please enter an comment!", Toast.LENGTH_SHORT).show();
            } else {
                new CreateCommentAsyncTask().execute(token,forumId, comment);
            }
            //replace this fragment with the Login Fragment
        });



        return view;
    }

    /**
     * This class should start the execution in the background
     */
    private class CreateCommentAsyncTask extends AsyncTask<Object, String, AsyncTaskResult<DataServices.Comment>> {

        @Override
        protected AsyncTaskResult<DataServices.Comment> doInBackground(Object... params) {
            AsyncTaskResult<DataServices.Comment> asyncTaskResult = null;
            String token = (String) params[0];
            Long forumId = (Long) params[1];
            String commentText = (String) params[2];
            DataServices.RequestException exception = null;
            try {
                if (token != null) {
                    DataServices.Comment data = DataServices.createComment(token,forumId, commentText);
                    asyncTaskResult = new AsyncTaskResult<DataServices.Comment>(data);
                }
            } catch (DataServices.RequestException anyError) {
                return new AsyncTaskResult<>(anyError);
            }

            //publishProgress(token);
            return asyncTaskResult;
        }

        protected void onPostExecute(AsyncTaskResult<DataServices.Comment> result) {
            // return a string token if login successful
            if (result.getError() != null) {
                // error handling here
                Toast.makeText(getActivity(), result.getError().getLocalizedMessage(), Toast.LENGTH_SHORT).show();

            } else if (isCancelled()) {
                // cancel handling here
            } else {
                newComment = result.getResult();
                new CommentsOfForumAsyncTask().execute(token, forum.getForumId());

            }

            //unlock UI components on fragment
            buttonLocker(true);

        }
    }

    /**
     * This class should start the execution in the background
     */
    private class CommentsOfForumAsyncTask extends AsyncTask<Object, String, AsyncTaskResult<ArrayList>> {

        @Override
        protected AsyncTaskResult<ArrayList> doInBackground(Object... params) {
            AsyncTaskResult<ArrayList> asyncTaskResult = null;
            String token = (String) params[0];
            Long forumId = (Long) params[1];

            DataServices.RequestException exception = null;
            try {
                if (token != null) {
                    ArrayList<DataServices.Comment> data = DataServices.getForumComments(token,forumId);
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
                commentsofForum = result.getResult();
                if (commentsofForum != null) {
                    txtComment.setText(commentsofForum.size() + " Comments");// get the recylerview size
                }
                Log.d("demo", "forumList Size: " + commentsofForum.size());

                DividerItemDecoration dividerItemDecoration = new DividerItemDecoration(recyclerView.getContext(),
                        layoutManager.getOrientation());
                recyclerView.addItemDecoration(dividerItemDecoration);
                adapter = new ForumDetailFragment.ForumDetailRecyclerViewAdapter(commentsofForum);
                recyclerView.setAdapter(adapter);

            }

            //unlock UI components on fragment
            buttonLocker(true);

        }
    }

    /**
     * This class should start the execution in the background
     */
    private class DeleteCommentAsyncTask extends AsyncTask<Object, String, AsyncTaskResult<String>> {

        @Override
        protected AsyncTaskResult<String> doInBackground(Object... params) {
            AsyncTaskResult<String> asyncTaskResult = null;
            String token = (String) params[0];
            Long forumId = (Long) params[1];
            Long commentId = (Long) params[2];


            DataServices.RequestException exception = null;
            try {
                if (token != null && forumId != null) {
                    DataServices.deleteComment(token,forumId, commentId);
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
                    new CommentsOfForumAsyncTask().execute(token, forum.getForumId());

                }


            }

            //unlock UI components on fragment
            buttonLocker(true);

        }
    }

    public class ForumDetailRecyclerViewAdapter extends RecyclerView.Adapter<ForumDetailRecyclerViewAdapter.ViewCommentsHolder> {
        ArrayList<DataServices.Comment> comments;
        /*String token;
        Long forumId;*/

        public ForumDetailRecyclerViewAdapter( ArrayList<DataServices.Comment> comments){
            this.comments = comments;
        }

        @Override
        public ForumDetailRecyclerViewAdapter.ViewCommentsHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(parent.getContext())
                    .inflate(R.layout.list_view_forum_comment_list, parent, false);
            ViewCommentsHolder vh = new ViewCommentsHolder(view);
            return vh;
        }

        @RequiresApi(api = Build.VERSION_CODES.O)
        @Override
        public void onBindViewHolder(@NonNull ForumDetailRecyclerViewAdapter.ViewCommentsHolder holder, int position) {
            DataServices.Comment comment = comments.get(position);
            holder.setupRowItem(comment);
        }

        @Override
        public int getItemCount() {
            return comments.size();
        }

        public class ViewCommentsHolder extends RecyclerView.ViewHolder {
            private TextView txtNameCreator, txtDescription, txtDateTimeCreated;
            private ImageView imageViewDelete;
            Long commentId;

            public ViewCommentsHolder(View view) {
                super(view);

                txtNameCreator = view.findViewById(R.id.txtNameCommentCreator);
                txtDescription = view.findViewById(R.id.txtCommentDescription);
                txtDateTimeCreated = view.findViewById(R.id.txtDateTimeCreated);
                imageViewDelete = view.findViewById(R.id.imageViewDelete);

                view.findViewById(R.id.imageViewDelete).setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Log.d("demo", "onClick: Delete " + txtTitle.getText().toString() );
                        //mListener.sortSelected(mLabel, "DESC");
                        new DeleteCommentAsyncTask().execute(token, forumId,commentId);

                    }
                });



            }

            @RequiresApi(api = Build.VERSION_CODES.O)
            public void setupRowItem( DataServices.Comment comment){

                commentId = comment.getCommentId();

                txtNameCreator.setText(comment.getCreatedBy().getName());
                txtDescription.setText(comment.getText());

                SimpleDateFormat myFormatObj = new SimpleDateFormat("dd-MM-yyyy HH:mm a");

                String formattedDate = myFormatObj.format(comment.getCreatedAt());
                txtDateTimeCreated.setText(formattedDate);

                String commentCreatorName = comment.getCreatedBy().getName();

                //if the currently logged user is people created this comment then visible Delete icon
                if(authResponse.getAccount().getName().equals(commentCreatorName)){
                    imageViewDelete.setVisibility(View.VISIBLE);
                    //imageViewDelete.setImageResource(R.drawable.avatar_female);
                } else{
                    imageViewDelete.setVisibility(View.INVISIBLE);
                }


            }
        }


    }


    /**
     * Locks or Unlocks button
     *
     * @param lock lock or unlock
     */
    public void buttonLocker(Boolean lock) {
        btnPost.setEnabled(lock);
    }





}