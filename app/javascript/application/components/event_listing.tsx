import * as React from 'react';
import {EventWithLocation} from '../models/event';
import {locationDescription} from '../models/location';
import {Link} from 'react-router-dom';

import {dateRange} from '../util';

interface Props {
  event: EventWithLocation;
  liked?: boolean;
}

export class EventListing extends React.Component<Props> {
  render() {
    const {event, liked} = this.props;
    return (
      <Link to={`/events/${event.id}`} className="event-listing">
        {liked && <div className="event-listing__marker">On Your Calendar</div>}
        <div className="event-listing__category">General</div>
        <div className="event-listing__name">{event.name}</div>
        <div className="event-listing__description"></div>
        <div className="event-listing__details">
          {locationDescription(event.location)} <br/> {dateRange(event.startAt, event.endAt)}
        </div>
      </Link>
    )
  }
}
