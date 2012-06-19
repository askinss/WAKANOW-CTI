/* binlog.h - binary log implementation */

/* Copyright (C) 2008 Graham Barr

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef binlog_h
#define binlog_h

#include "job.h"

typedef struct binlog *binlog;

struct binlog {
  binlog next;
  unsigned int refs;
  char path[];
};

extern char *binlog_dir;
extern size_t binlog_size_limit;

/* Return the number of locks acquired: either 0 or 1. */
int binlog_lock();

void binlog_write_job(job j);
void binlog_read(job binlog_jobs);
void binlog_close();
const char *binlog_oldest_index();
const char *binlog_current_index();

#endif

