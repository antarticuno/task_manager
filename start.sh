#!/bin/bash

export MIX_ENV=prod
export PORT=4795

echo "Stopping old copy of app, if any..."

_build/prod/rel/task_manager/bin/task_manager stop || true

echo "Starting app..."

_build/prod/rel/task_manager/bin/task_manager foreground

