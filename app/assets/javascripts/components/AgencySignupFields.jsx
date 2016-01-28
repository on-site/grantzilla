class AgencySignupFields extends React.Component {
  constructor(props) {
    super(props)
    this.state = { disableAgency: false }
    this.emailChanged = this.emailChanged.bind(this);
  }

  emailChanged(e) {
    let disableAgency = e.target.value.indexOf('@hifinfo.org') > -1;
    this.setState({disableAgency: disableAgency});
  }

  render() {
    let disableAgency = this.state.disableAgency;
    let agencySelectOptions = this.props.agencies.map((agency) => {
      return (
        <option  key={agency.id} value={agency.id}>{agency.name}</option>
      )
    });

    return (
      <div>
        <div className="form-group">
          <label for="user_email">Email</label>
          <input className="form-control" type="email" name="user[email]" onChange={this.emailChanged} id="user_email"/>
        </div>
        <div className="form-group">
          <label for="user_agency_id">Agency</label>
          <select disabled={disableAgency} className="form-control" name="user[agency_id]" id="user_agency_id">
            <option value=""></option>
            {agencySelectOptions}
          </select>
        </div>
      </div>
    );
  }
}
