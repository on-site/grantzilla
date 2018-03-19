// Keep this component stateless for markup only
// don't change the element ids;
let GrantControlsForm = (props) => (
  <form onSubmit={props.handleSubmit}>
    <div className="form-group">
      <label className="control-label" htmlFor="gcf-statusId">Status</label>
      <select className="select form-control" id="gcf-statusId" defaultValue={props.grant.grant_status_id}>
        {props.statuses.map(status => <option value={status.id} key={status.id}>{status.description}</option>)}
      </select>
    </div>

    <div className="form-group">
      <label className="control-label" htmlFor="gcf-grantAmount">Grant Amount</label>
      <div className="input-group">
        <div className="input-group-addon">$</div>
        <input className="form-control" id="gcf-grantAmount" name="number" type="text"
               defaultValue={accounting.formatNumber(props.grant.grant_amount, 2, "")} />
      </div>
    </div>

    <div className="form-group">
      <label className="control-label" htmlFor="gcf-grantRsgp">RSGP</label>
        <input className="form-control" id="gcf-grantRsgp" type="text"
               defaultValue={props.grant.grant_rsgp} />
    </div>

    <div className="form-group">
      <label className="control-label" htmlFor="gcf-checkNumber">Check Number</label>
      <div className="input-group">
        <div className="input-group-addon">#</div>
        <input className="form-control" id="gcf-checkNumber" name="number" type="text"
               defaultValue={props.payee.check_number} />
      </div>
    </div>

    <div className="form-group">
      <label className="control-label" htmlFor="gcf-payee">Payee</label>
      <div className={props.payee.name == null ? 'form-control-static text-italic' : 'form-control-static'} id="gcf-payee">
        {props.payee.name != null ? props.payee.name : 'Unspecified'}
      </div>
    </div>

    <div className="form-group">
      <label className="control-label" htmlFor="gcf-grantSurvey">Survey</label>
      <select className="select form-control" id="gcf-grantSurvey" defaultValue={props.grant.grant_survey}>
        <option value="false">No</option>
        <option value="true">Yes</option>
      </select>
    </div>

    <div className="form-group hidden">
      <a href="#"><span className="glyphicon glyphicon-new-window"></span> Budget Worksheet</a>
    </div>

    <div className="form-group">
      <div>
        <button className="btn btn-default" name="submit" type="submit">
          Save Status
        </button>
      </div>
    </div>
  </form>
);
