class GrantControls extends React.Component {
  constructor(props) {
    super(props);
    this.state = { saved: false, errors: null }
  }
  save(e) {
    e.preventDefault();
    let $form = $(e.target);
    let data = {
      grant: {
        grant_status_id: $form.find("#gcf-statusId").val(),
        grant_amount: $form.find("#gcf-grantAmount").val()
      },
      payee: {
        check_number: $form.find("#gcf-checkNumber").val()
      }
    };
    $.ajax(`/grants/${this.props.grant.id}/update_controls`, {
      type: 'PATCH',
      data
    })
    .done(resp => {
      this.setState({saved: true});
      setTimeout(() => this.setState({saved: false}), 5000);
    })
    .fail(errors => this.setState({errors}));
  }
  render() {
    return (
      <div className="well">
        <h4>HIF Controls</h4>

        <GrantControlsForm handleSubmit={this.save.bind(this)} {...this.props} />

        { this.state.saved ? <AlertBox type="success" message="Saved" /> : null }
        { this.state.errors ? <AlertBox type="danger" message={this.state.errors} /> : null }
      </div>
    );
  }
}
