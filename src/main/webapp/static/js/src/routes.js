/** Routing Configuration --- */

angular.module('open').config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
    $routeProvider

        /** --- Bills --- */

        .when(ctxPath + '/bills', { templateUrl: ctxPath + '/partial/content/bill/bill-search', reloadOnSearch: false })
        .when(ctxPath + '/bills/:session/:printNo', { templateUrl: ctxPath + '/partial/content/bill/bill-view', reloadOnSearch: false })

        /** --- Agendas --- */

        .when(ctxPath + '/agendas', { templateUrl: ctxPath + '/partial/content/agenda/agenda-search', reloadOnSearch: false})
        .when(ctxPath + '/agendas/:weekOf', { templateUrl: ctxPath + '/partial/content/agenda/agenda-view', reloadOnSearch: false })
        .when(ctxPath + '/agendas/:year/:agendaNo', { templateUrl: ctxPath + '/partial/content/agenda/agenda-view', reloadOnSearch: false })
        .when(ctxPath + '/agendas/:year/:agendaNo/:comm', { templateUrl: ctxPath + '/partial/content/agenda/agenda-view', reloadOnSearch: false })

        /** --- Calendars --- */

        .when(ctxPath + '/calendars', { templateUrl: ctxPath + '/partial/content/calendar/calendar-search', reloadOnSearch: false })
        .when(ctxPath + '/calendars/:year/:calNo', { templateUrl: ctxPath + '/partial/content/calendar/calendar-view', reloadOnSearch: false })

        /** --- Laws --- */

        .when(ctxPath + '/laws', { templateUrl: ctxPath + '/partial/content/law/law-search', reloadOnSearch: false})
        .when(ctxPath + '/laws/:lawId', { templateUrl: ctxPath + '/partial/content/law/law-view', reloadOnSearch: false })

        /** --- Members --- */
        .when(ctxPath + '/members', { templateUrl: ctxPath + '/partial/content/member/member-search', reloadOnSearch: false})
        .when(ctxPath + '/members/:sessionYear/:memberId', { templateUrl: ctxPath + '/partial/content/member/member-view', reloadOnSearch: false})

        /** --- Transcripts --- */

        .when(ctxPath + '/transcripts', { templateUrl: ctxPath + '/partial/content/transcript/transcript-list', reloadOnSearch: false})
        .when(ctxPath + '/transcripts/session/:filename/', { templateUrl: ctxPath + '/partial/content/transcript/session-transcript-view', reloadOnSearch: false})
        .when(ctxPath + '/transcripts/hearing/:filename/', { templateUrl: ctxPath + '/partial/content/transcript/hearing-transcript-view'})

        /** --- Reports --- */

        .when(ctxPath + '/admin/report/spotcheck', {
            templateUrl: ctxPath + '/partial/report/spotcheck-report-page',
            reloadOnSearch: false
        })

        /** --- Admin --- */

        .when(ctxPath + '/admin', { templateUrl: ctxPath + '/partial/admin/dashboard', reloadOnSearch: false })
        .when(ctxPath + '/admin/account', { templateUrl: ctxPath + '/partial/admin/account', reloadOnSearch: false })
        .when(ctxPath + '/admin/logs', { templateUrl: ctxPath + '/partial/admin/logs', reloadOnSearch: false })
        .when(ctxPath + '/admin/logout', {templateUrl: ctxPath + '/partial/admin/logout'})
        .when(ctxPath + '/admin/reports', {templateUrl: ctxPath + '/partial/admin/reports', reloadOnSearch: false})
        .when(ctxPath + '/admin/members', { templateUrl: ctxPath + '/partial/admin/members', reloadOnSearch: false })
        .when(ctxPath + '/admin/member/:memberId', { templateUrl: ctxPath + '/partial/admin/member', reloadOnSearch: false })
        .when(ctxPath + '/admin/members/verify/:memberId', { templateUrl: ctxPath + '/partial/admin/verify', reloadOnSearch: false })
        .when(ctxPath + '/admin/email', {templateUrl: ctxPath + '/partial/admin/email', reloadOnSearch: false})
        .when(ctxPath + '/admin/email/batchEmail', {templateUrl: ctxPath + '/partial/admin/email/batchEmail', reloadOnSearch: false})


        /** --- Docs --- */

        .when(ctxPath + '/docs', { redirectTo: ctxPath + '/docs'})

        /** --- Logout --- */

        .when(ctxPath + '/logout', { redirectTo: ctxPath + '/logout', reloadOnSearch: true})

        /** --- Home Page --- */

        .otherwise({
            redirectTo: ctxPath + '/bills'
        });

    $locationProvider.html5Mode(true);
    $locationProvider.hashPrefix('!');
}]);
