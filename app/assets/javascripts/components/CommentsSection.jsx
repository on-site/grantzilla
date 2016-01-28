class CommentsSection extends React.Component {
  constructor(props) {
    super(props);
    this.state = { comments: this.props.current_comments };
  }
  saveNewComment(e) {
    e.preventDefault();
    let $form = $(e.target);
    let $gcText = $form.find("#gc-text");
    $.post(`/grants/${this.props.grant.id}/add_comment`, { body: $gcText.val() })
    .done(resp => {
      let currentComments = this.state.comments;
      currentComments.unshift(resp);
      this.setState({ comments: currentComments });
      $gcText.val("");
    })
    .fail(errors => console.log(errors));
  }
  render() {
    return (
      <div className="well">
        <h4>Comments</h4>
        <CommentForm handleSubmit={this.saveNewComment.bind(this)} />
        {this.state.comments.map(comment => <Comment key={comment.id} {...comment} />)}
      </div>
    );
  }
}
