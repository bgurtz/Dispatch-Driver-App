# Flutter Application Driver App

A Flutter-based driver dispatch, 
load tracking, and timesheet application for Texcon operations.

## Project Status

This project is in active development. The initial version will focus on the core driver clock-in, 
load-entry, timesheet, and administrator-management workflows. 
Features will be refined and expanded as the project progresses.

## Planned Features

### Driver Clock-In and Clock-Out

- Geofence-based clock-in and clock-out
- 125-yard radius around the Texcon location
- Administrator setting to temporarily disable geofencing for testing
- Large, easy-to-use **Clock In** and **Clock Out** button
- Current shift status
- Pre-trip tracking
- Post-trip tracking
- Total shift time
- Total load time

### Driver Landing Page

- Improved driver-focused landing page
- Polished mobile-friendly interface
- Current shift status
- Current assigned load
- Today's loads
- Today's hours
- Weekly hours
- Weekly estimated pay
- Clear visibility into current work activity

### Load Entry and Tracking

- Improved mobile load-entry workflow
- Automatically populate the normal drop location when a G-Code is selected
- Option for drivers to select **Different Drop Location**
- Better mobile controls for entering load details
- Clear load-status indicators
- Live load timer
- Current-load visibility

### Timesheets

- Full driver timesheet functionality
- Daily timesheet breakdown
- Pre-trip time
- Individual loads
- Post-trip time
- Clock-out time
- Total shift time
- Total load time
- Daily, weekly, and payroll-hour visibility

### Administrator Dashboard

- View drivers currently clocked in
- View the truck each driver is operating
- View each driver's current load
- View today's hours by driver
- View drivers currently on leave
- Search and filter drivers
- Monitor active operations from a centralized dashboard

### Truck and Trailer Information

- Truck number
- Trailer number
- Trailer type
- Truck type
- Driver-to-truck assignment visibility

### Administrator Editing and Audit Trail

- Edit completed driver timesheets
- Edit individual loads
- Track administrator changes
- Maintain audit information showing:
  - Which administrator made a change
  - What information was changed
  - When the change was made
  - Original and updated values where applicable

### Reports

- Daily reports
- Weekly reports
- Driver reports
- Payroll-hours reports
- Excel export
- PDF export
- Print-friendly reports

## Deployment Considerations

The production deployment will include configuration and security controls for:

- Environment variables
- Database location
- Upload directory
- Production session security
- Secure administrator access
- Data backup and recovery planning
- File and report export management

## Getting Started

This is a Flutter project.

To run the project locally:

```bash
flutter pub get
flutter run
```

For help getting started with Flutter, see the official documentation:

- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Getting Started Guide](https://docs.flutter.dev/get-started/install)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)