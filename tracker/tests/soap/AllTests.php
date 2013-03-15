<?php
# Mantis - a php based bugtracking system

# Mantis is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# Mantis is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Mantis.  If not, see <http://www.gnu.org/licenses/>.

/**
 * @package Tests
 * @subpackage UnitTests
 * @copyright Copyright (C) 2002 - 2010  Mantis Team   - mantisbt-dev@lists.sourceforge.net
 * @link http://www.mantisbt.org
 */

/**
 * Test config
 */
require_once dirname(__FILE__) . '/../TestConfig.php';

require_once 'EnumTest.php';
require_once 'IssueAddTest.php';
require_once 'IssueNoteTest.php';
require_once 'IssueUpdateTest.php';
require_once 'FilterTest.php';
require_once 'AttachmentTest.php';
require_once 'LoginTest.php';

/**
 * @package    Tests
 * @subpackage UnitTests
 * @copyright Copyright (C) 2002 - 2010  Mantis Team   - mantisbt-dev@lists.sourceforge.net
 * @link http://www.mantisbt.org
 */
class Soap_AllTests extends PHPUnit_Framework_TestSuite
{
    protected function setUp()
    {
        if ( ! extension_loaded('soap') ) {
            $this->markTestSuiteSkipped(
                    'The SOAP extension is not available.'
                    );
        }

    }

    public static function suite()
    {
        $suite = new Soap_AllTests('SOAP Interface');

        $suite->addTestSuite('EnumTest');
        $suite->addTestSuite('IssueAddTest');
        $suite->addTestSuite('IssueNoteTest');
        $suite->addTestSuite('IssueUpdateTest');
        $suite->addTestSuite('FilterTest');
        $suite->addTestSuite('AttachmentTest');
        $suite->addTestSuite('LoginTest');

        return $suite;
    }
}
