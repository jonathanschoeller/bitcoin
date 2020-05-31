#!/usr/bin/env bash
#
# Copyright (c) 2018-2020 The Bitcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.
#
# Check commit message format.

for SHA in $(git log --format=format:%H $(git merge-base master HEAD)..HEAD) ; do
    BODY=$(git log -1 --pretty=format:%B $SHA)
    echo $BODY | grep -P "^.{1,50}(\\n\\n[\\s\\S]*)?$"
    if ! [[ "$BODY" =~ ^.{1,50}(\n\n[\s\S]*)?$ ]]; then
        # echo "Commit ${SHA} seems to have an incorrectly formatted message"
        EXIT_CODE=1
    fi
done
exit ${EXIT_CODE}
