let AlertBox = (props) => (
  <div className={`alert alert-${props.type}`}>
    {props.message}
  </div>
);
