class CommentForm extends React.Component {
  render() {
    return (
      <form onSubmit={this.props.handleSubmit}>
        <div className="form-group">
          <textarea className="form-control" id="gc-text"></textarea>
        </div>
        <div className="form-group">
          <div>
            <button className="btn btn-default" name="submit" type="submit">
              Add Comment
            </button>
          </div>
        </div>
      </form>
    );
  }
}
