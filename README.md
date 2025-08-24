# UniVerse – the campus superapp (Flutter, Gen‑Z theme)

Offline‑first campus superapp for **web and mobile**: Home feed (events + marketplace), **Schedule (timetable)**, **Events**, **Marketplace** (rides/classifieds/lost&found), **Profile** with theming.

## Run

```
flutter pub get
flutter run -d chrome
```

or Android/iOS devices.

## Roadmap (what to add next)

- Attendance nudges & streaks (local notifications)
- Club admin tools: RSVP lists, QR check‑ins, role permissions
- Ticketing (UPI link‑outs), waitlists
- Campus SSO adapters (email/OTP), verified roles (student, club admin)
- Push notifications (local first, optional FCM)
- Map view + safety features (SOS shortcut)
- Moderation: report/approve flow, spam/fraud heuristics
- Import/export: CSV/JSON; public share links for events
- Multi‑campus mode + ambassador dashboards

## Verification & Campus scoping

- On first launch, enter your **Campus Code** (default: `UNI-DEMO`) and **Student ID**.
- Only IDs whitelisted in `assets/allowed_ids.json` (or added locally in Profile → Admin Tools) can enter.
- All content (events, posts, clubs) is **filtered by campusId** so you only see your university's activities.

## Theming

- Sora font + neon seed colors. Enhanced gradient app bar and background for a bold Gen‑Z look.
- Switch themes and dark mode in Profile.
