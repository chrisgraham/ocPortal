<?php

function get_ocportal_support_timings($open, $member_id, $ticket_type_name, $last_time, $say_more = false)
{
    $d = new ocp_tempcode();

    if (!$open) {
        return $d;
    }

    if (has_privilege($member_id, 'support_operator')) {
        $d->attach(div('Last reply was by staff'));
    } else {
        $timestamp_to_answer_by = mixed();
        switch ($ticket_type_name) {
            // Very rough. Ignores weekends (okay, as means over-delivering) and in-day times (will be tracking more carefully for v. high priority tickets)
            case 'Budget priority':
                $timestamp_to_answer_by = within_business_hours(7 * 8, $last_time);
                break;
            case 'Normal priority':
                $timestamp_to_answer_by = within_business_hours(3 * 8, $last_time);
                break;
            case 'Day priority':
                $timestamp_to_answer_by = within_business_hours(8, $last_time);
                break;
            case 'High priority':
                $timestamp_to_answer_by = within_business_hours(3, $last_time);
                break;
            case 'Emergencies':
                $timestamp_to_answer_by = within_business_hours(1, $last_time);
                break;
        }
        if (!is_null($timestamp_to_answer_by)) {
            $text = 'Next reply by: ' . date('D jS M', $timestamp_to_answer_by);
            if ($say_more) {
                $text .= ' (Response times are determined by the requested ticket priority. Any requested programming tasks are started at the time of response. Response times apply between replies, as well as initially. Tickets may not be read until the next response time, so higher priority requests should be made in a new ticket. Often we will beat response times but this should not be considered a precedent.)';
            }
            $d->attach(div($text));
        }
    }

    return $d;
}

function within_business_hours($hours, $time)
{
    while ($hours > 0) {
        // Go forward an hour
        $time += 60 * 60;
        $_time = tz_time($time, get_site_timezone()); // Convert to site time-zone

        // Skip outside business hours from counting
        $dow = date('D', $_time);
        if ($dow == 'Sat' || $dow == 'Sun') {
            continue;
        }
        $hour = intval(date('H', $_time));
        if ($hour < 10 || $hour >= 18) { // Support hours are 10am-6pm (as 9am-10am is setting up time)
            continue;
        }

        // Okay, a business hour, so deprecate our countdown
        $hours--;
    }

    return $time;
}

