class GrantControls extends React.Component {
  save(e) {
    e.preventDefault();
    let $form = $(e.target);
    let data = {
      grant_amount: $form.find("#gcf-grantAmount").val(),
      check_number: $form.find("#gcf-checkNumber").val(),
      payee: $form.find("#gcf-payee").val()
    };
    $.ajax(`/grants/${this.props.grantId}/update_controls`, {
      type: 'PATCH',
      data: { grant: data }
    });
  }
  render() {
    return (
      <div className="well">
        <h4>HIF Controls</h4>

        <GrantControlsForm handleSubmit={this.save.bind(this)} />
      </div>
    );
  }
}
