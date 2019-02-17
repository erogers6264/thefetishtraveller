import React from 'react';
import { Location } from '../models/location';
import { Link } from 'react-router-dom';

import Card from './card';

interface Props {
  location: Location;
}

export class LocationListing extends React.Component<Props> {
  public render() {
    const { location } = this.props;
    return (
      <Link to={`/locations/${location.slug}`}>
        <Card>
          <div>{location.name}</div>
          <div>
            {location.city}, {location.countryCode}
          </div>
        </Card>
      </Link>
    );
  }
}