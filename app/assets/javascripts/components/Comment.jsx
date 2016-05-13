let Comment = (props) => (
  <div className="one-comment">
    <div className="comment-body">
      {props.body}
    </div>

    <span className="comment-date">{moment(props.created_at).fromNow()}</span>
    <span className="comment-author"> by {props.first_name} {props.last_name}</span>
  </div>
);
