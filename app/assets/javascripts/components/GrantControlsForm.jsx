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
      <label className="control-label" htmlFor="gcf-checkNumber">Check Number</label>
      <div className="input-group">
        <div className="input-group-addon">#</div>
        <input className="form-control" id="gcf-checkNumber" name="number" type="text"
               defaultValue={props.payee.check_number} />
      </div>
    </div>

    <div className="form-group">
      <label className="control-label" htmlFor="gcf-payee">Payee</label>
      <div className="form-control-static" id="gcf-payee">
        {props.payee.name}
      </div>
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
