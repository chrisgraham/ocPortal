<?php

function get_ocportal_support_timings($open, $member_id, $ticket_type_name, $last_time)
{
    $d = new ocp_tempcode();

    if (!$open) {
        return $d;
    }

    if (has_privilege($member_id, 'view_others_tickets')) {
        $d->attach(div('Last reply was by staff'));
    } else {
        $timestamp_to_answer_by = mixed();
        switch ($ticket_type_name) {
            // Very rough. Ignores weekends (okay, as means over-delivering) and in-day times (will be tracking more carefully for v. high priority tickets)
            case 'Budget priority':
                $timestamp_to_answer_by = strtotime('+7 days', $last_time);
                break;
            case 'Normal priority':
                $timestamp_to_answer_by = strtotime('+3 days', $last_time);
                break;
            case 'Day priority':
                $timestamp_to_answer_by = $last_time;
                break;
            case 'High priority':
                $timestamp_to_answer_by = $last_time;
                break;
            case 'Emergencies':
                $timestamp_to_answer_by = $last_time;
                break;
        }
        if (!is_null($timestamp_to_answer_by)) {
            $d->attach(div('Estimated date to answer on: ' . date('D jS M', $timestamp_to_answer_by)));
        }
    }

    return $d;
}
