/* Tests the multiply instructions.
 *
 * This is not a comprehensive test of any instruction (yet).
 * Of course what is really needed is a comprehensive instruction test...
 *
 *
 * Copyright (C) 1999-2006 OpenCores
 *   Contributors various OpenCores participants
 * Copyright (C) 2010 Embecosm Limited
 *   Contributor Jeremy Bennett <jeremy.bennett@embecosm.com>
 * Copyright (C) 2012 R. Diez
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation; either version 3 of the License, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


#include "TestHelpers.inc"


        STANDARD_TEST_ENVIRONMENT

        .section .exception_vectors

        #include "RangeExceptionHandler.inc"


        .section .text
start_tests:
        PUSH LINK_REGISTER_R9


        // Test l.mul.
        //
        // Note that the l.mul instruction has been modified so that it always
        // resets the Carry flag. Only the Overflow flag is meaningful.

        // Multiply two small positive numbers.
        TEST_INST_I32_I32 l.mul, 0x00000002, 0x00000003

        // Multiply two quite large positive numbers.
        TEST_INST_I32_I32 l.mul, 0x00008001, 0x0000fffe

        // Multiply two slightly too large positive numbers.
        TEST_INST_I32_I32 l.mul, 0x00008000, 0x00010000

        // Multiply two large positive numbers.
        TEST_INST_I32_I32 l.mul, 0x00010000, 0x00010000

        // Multiply two small negative numbers.
        TEST_INST_I32_I32 l.mul, 0xfffffffe, 0xfffffffd

        // Multiply two quite large negative numbers.
        TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0002

        // Multiply two slightly too large negative numbers.
        TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0000

        // Multiply two large negative numbers.
        TEST_INST_I32_I32 l.mul, 0xffff0000, 0xfffeffff

        // Multiply one small negative number and one small positive number.
        TEST_INST_I32_I32 l.mul, 0x00000002, 0xfffffffd

        // Multiply one quite large negative number and one quite large positive number.
        TEST_INST_I32_I32 l.mul, 0xffff8000, 0x00010000

        // Multiply one slightly too large negative number and one slightly
        // too large positive number.
        TEST_INST_I32_I32 l.mul, 0xffff7fff, 0x00010000

        // Multiply the largest negative number by positive unity.
        TEST_INST_I32_I32 l.mul, 0x80000000, 0x00000001

        // ------ Check that range exceptions are triggered.

        // Check that an Overflow causes a RANGE Exception.
        SET_SR_FLAGS_FOR_RANGE_EXCEPTION r2, r3
        TEST_INST_I32_I32 l.mul, 0x00008000, 0x00010000

        // No Overflow flag, no RANGE Exception.
        SET_SR_FLAGS_FOR_RANGE_EXCEPTION r2, r3
        TEST_INST_I32_I32 l.mul, 0x00000002, 0xfffffffd

        // Check that an Overflow causes a RANGE Exception.
        SET_SR_FLAGS_FOR_RANGE_EXCEPTION r2, r3
        TEST_INST_I32_I32 l.mul, 0xffff7fff, 0xffff0000

        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3


        // Test l.muli

        // Multiply two small positive numbers.
        TEST_INST_I32_I16 l.muli, 0x00000002, 0x0003

        // Multiply two quite large positive numbers.
        TEST_INST_I32_I16 l.muli, 0x00010002, 0x7fff

        // Multiply two slightly too large positive numbers.
        TEST_INST_I32_I16 l.muli, 0x00020000, 0x4000

        // Multiply two large positive numbers.
        TEST_INST_I32_I16 l.muli, 0x00040000, 0x4000

        // Multiply two small negative numbers.
        TEST_INST_I32_I16 l.muli, 0xfffffffe, 0xfffd

        // Multiply two quite large negative numbers.
        TEST_INST_I32_I16 l.muli, 0xfffefffe, 0x8001

        // Multiply two slightly too large negative numbers.
        TEST_INST_I32_I16 l.muli, 0xfffe0000, 0xbfff

        // Multiply two large negative numbers.
        TEST_INST_I32_I16 l.muli, 0xfffdfffe, 0x8000

        // Multiply one small negative number and one small positive number.
        TEST_INST_I32_I16 l.muli, 0x00000002, 0xfffd

        // Multiply one quite large negative number and one quite large positive number.
        TEST_INST_I32_I16 l.muli, 0x00010000, 0x8000

        // Multiply one slightly too large negative number and one slightly
        // too large positive number.
        TEST_INST_I32_I16 l.muli, 0xfffdfffc, 0x4000

        // Multiply the largest negative number by positive unity.
        TEST_INST_I32_I16 l.muli, 0x80000000, 0x0001

        // ------ Check that range exceptions are triggered.

        // Check that an Overflow causes a RANGE Exception.
        SET_SR_FLAGS_FOR_RANGE_EXCEPTION r2, r3
        TEST_INST_I32_I16 l.muli, 0x00020000, 0x4000

        // No Overflow flag, no RANGE Exception.
        SET_SR_FLAGS_FOR_RANGE_EXCEPTION r2, r3
        TEST_INST_I32_I16 l.muli, 0xfffffffe, 0xfffd

        // Check that an Overflow causes a RANGE Exception.
        SET_SR_FLAGS_FOR_RANGE_EXCEPTION r2, r3
        TEST_INST_I32_I16 l.muli, 0xfffdfffe, 0x8000

        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3


        // Test l.mulu

        // Multiply two small positive numbers.
        TEST_INST_I32_I32 l.mulu, 0x00000002, 0x00000003

        // Multiply two quite large positive numbers.
        TEST_INST_I32_I32 l.mulu, 0x00008001, 0x0000fffe

        // Multiply two slightly too large positive numbers.
        TEST_INST_I32_I32 l.mulu, 0x00008000, 0x00010000

        // Multiply two large positive numbers.
        TEST_INST_I32_I32 l.mulu, 0x00010000, 0x00010000

        // Multiply two small negative numbers.
        TEST_INST_I32_I32 l.mulu, 0xfffffffe, 0xfffffffd

        // Multiply two quite large negative numbers.
        TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0xffff0002

        // Multiply two slightly too large negative numbers.
        TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0xffff0000

        // Multiply two large negative numbers.
        TEST_INST_I32_I32 l.mulu, 0xffff0000, 0xfffeffff

        // Multiply one small negative number and one small positive number.
        TEST_INST_I32_I32 l.mulu, 0x00000002, 0xfffffffd

        // Multiply one quite large negative number and one quite large
        // positive number.
        TEST_INST_I32_I32 l.mulu, 0xffff8000, 0x00010000

        // Multiply one slightly too large negative number and one slightly
        // too large positive number.
        TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0x00010000

        // Multiply the largest negative number by positive unity.
        TEST_INST_I32_I32 l.mulu, 0x80000000, 0x00000001


        // ------ Check that range exceptions are NEVER triggered.

        SET_SPR_SR_FLAGS SPR_SR_OVE, r2, r3

        // Check that what would cause an overflow alone in 2's complement does
        // not cause a RANGE Exception.
        TEST_INST_I32_I32 l.mulu, 0x00008000, 0x00010000

        // Check that a carry alone does not cause a RANGE Exception.
        TEST_INST_I32_I32 l.mulu, 0x00000002, 0xfffffffd

        // Check that what would cause an overflow and carry in 2's complement
        // does not cause a RANGE Exception.
        TEST_INST_I32_I32 l.mulu, 0xffff7fff, 0xffff0000

        CLEAR_SPR_SR_FLAGS SPR_SR_OVE, r2, r3


        POP LINK_REGISTER_R9
        RETURN_TO_LINK_REGISTER_R9
