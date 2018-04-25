import * as React from 'react';
import {connect} from 'react-redux';
import {Event} from '../models/event';
import {Location} from '../models/location';
import {DB, DBAction, writeDB} from '../state';
import Container from '../components/container';
import Form from '../components/form';
import FormField from '../components/form_field';
import Select from '../components/select';
import {dateRange} from '../util';
import {Link} from 'react-router-dom';

interface Props {
  id: string;
  event?: Event;
  dispatch: (DBAction) => void;
  locations: Location[];
}

const events = writeDB.table('events');

class EventEdit extends React.Component<Props> {
  render() {
    let {event,dispatch, locations} = this.props;
    if(!event) { return null };
    return (
      <Container>
        <h1>{event.name}</h1>
        <Form model={event} onChange={(model) => this.update(model)} onSubmit={(model) => this.submit(model)}>
          <FormField name="name"/>
          <FormField name="organizerName"/>
          <FormField name="website"/>
          <Select name="locationId" options={locations.map(location => [location.id, location.name])}/>
          <Link to="/locations/new">Create new location</Link>
          <input type="submit"/>
        </Form>
      </Container>
    )
  }

  private update(values: Partial<Event>) {
    this.props.dispatch(events.update(this.props.id, values));
  }

  private submit(values: Partial<Event>) {
    this.props.dispatch(events.update(this.props.id, {fieldsToSync: Object.keys(values)}));
  }
}

const mapStateToProps = (state, props) => {
  const id = props.match.params.id;
  const db = new DB(state);
  return {event: db.table('events').find(id), id, locations: db.table('locations').all};
}

export default connect(mapStateToProps)(EventEdit)
