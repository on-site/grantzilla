const {Table, Column, Cell} = FixedDataTable;

var SortTypes = {
  ASC: 'ASC',
  DESC: 'DESC',
};

function reverseSortDirection(sortDir) {
  return sortDir === SortTypes.DESC ? SortTypes.ASC : SortTypes.DESC;
}

class SortHeaderCell extends React.Component {
  constructor(props) {
    super(props);

    this._onSortChange = this._onSortChange.bind(this);
  }

  render() {
    var {sortDir, children, ...props} = this.props;
    return (
      <Cell {...props}>
        <a onClick={this._onSortChange}>
          {children} {sortDir ? (sortDir === SortTypes.DESC ? '↓' : '↑') : ''}
        </a>
      </Cell>
    );
  }

  _onSortChange(e) {
    e.preventDefault();

    if (this.props.onSortChange) {
      this.props.onSortChange(
        this.props.columnKey,
        this.props.sortDir ?
          reverseSortDirection(this.props.sortDir) :
          SortTypes.DESC
      );
    }
  }
}

const TextCell = ({rowIndex, data, columnKey, ...props}) => (
  <Cell {...props}>
    {data.getObjectAt(rowIndex)[columnKey]}
  </Cell>
);

class Links extends React.Component {
  render() {
    console.log(this.props);
    const {rowIndex, data, ...props} = this.props;
    const id = data.getObjectAt(rowIndex)["id"];
    return (
      <Cell {...props}>
        <a href={`/grants/${id}`}>View</a> | <a href={`/grants/${id}/edit`}>Edit</a>
      </Cell>
    );
  }
}

class DataListWrapper {
  constructor(indexMap, data) {
    this._indexMap = indexMap;
    this._data = data;
  }

  getSize() {
    return this._indexMap.length;
  }

  getObjectAt(index) {
    return this._data.getObjectAt(
      this._indexMap[index],
    );
  }
}

class DataListStore {
  constructor(data){
    this._cache = data;
  }

  getObjectAt(index) {
    if (index < 0 || index > this.size){
      return undefined;
    }
    if (this._cache[index] === undefined) {
      this._cache[index] = this.createFakeRowObjectData(index);
    }
    return this._cache[index];
  }

  getAll() {
    return this._cache.slice();
  }

  getSize() {
    return this._cache.length;
  }
}

class GrantsList extends React.Component {
  constructor(props) {
    super(props);

    this._dataList = new DataListStore(JSON.parse(this.props.grants));

    this._defaultSortIndexes = [];
    var size = this._dataList.getSize();
    for (var index = 0; index < size; index++) {
      this._defaultSortIndexes.push(index);
    }

    this.state = {
      sortedDataList: this._dataList,
      colSortDirs: {},
    };

    this._onSortChange = this._onSortChange.bind(this);
  }

  _onSortChange(columnKey, sortDir) {
    var sortIndexes = this._defaultSortIndexes.slice();
    sortIndexes.sort((indexA, indexB) => {
      var valueA = this._dataList.getObjectAt(indexA)[columnKey];
      var valueB = this._dataList.getObjectAt(indexB)[columnKey];
      var sortVal = 0;
      if (valueA > valueB) {
        sortVal = 1;
      }
      if (valueA < valueB) {
        sortVal = -1;
      }
      if (sortVal !== 0 && sortDir === SortTypes.ASC) {
        sortVal = sortVal * -1;
      }

      return sortVal;
    });

    this.setState({
      sortedDataList: new DataListWrapper(sortIndexes, this._dataList),
      colSortDirs: {
        [columnKey]: sortDir,
      },
    });
  }

  render() {
    var {sortedDataList, colSortDirs} = this.state;
    return (
      <Table
        rowHeight={50}
        rowsCount={sortedDataList.getSize()}
        headerHeight={50}
        width={1000}
        height={500}
        {...this.props}>
        <Column
          columnKey="primary_applicant_name"
          header={
            <SortHeaderCell onSortChange={this._onSortChange} sortDir={colSortDirs.primary_applicant_name}>
              Primary Applicant
            </SortHeaderCell>
          }
          cell={<TextCell data={sortedDataList} />}
          width={250}
        />
        <Column
          columnKey="application_date"
          header={
            <SortHeaderCell onSortChange={this._onSortChange} sortDir={colSortDirs.application_date}>
              Application Date
            </SortHeaderCell>
          }
          cell={<TextCell data={sortedDataList} />}
          width={150}
        />
        <Column
          columnKey="agency_name"
          header={
            <SortHeaderCell onSortChange={this._onSortChange} sortDir={colSortDirs.agency_name}>
              Agency
            </SortHeaderCell>
          }
          cell={<TextCell data={sortedDataList} />}
          width={200}
        />
        <Column
          columnKey="case_worker_name"
          header={
            <SortHeaderCell onSortChange={this._onSortChange} sortDir={colSortDirs.case_worker_name}>
              Case Worker
            </SortHeaderCell>
          }
          cell={<TextCell data={sortedDataList} />}
          width={200}
        />
        <Column
          columnKey="status_name"
          header={
            <SortHeaderCell onSortChange={this._onSortChange} sortDir={colSortDirs.status_name}>
              Status
            </SortHeaderCell>
          }
          cell={<TextCell data={sortedDataList} />}
          width={100}
        />
        <Column
          header={<Cell></Cell>}
          cell={<Links data={sortedDataList}></Links>}
          width={100}
        />
      </Table>
    );
  }
}
