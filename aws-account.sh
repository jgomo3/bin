#!/usr/bin/env bash

# This tool is useful to double check that you are working with the
# AWS account you expect to work with, and not with a different one by
# accident.
# 
# Retrieves the AWS account ID of the current user.  If it is one of
# the accounts we support, it will display it's known alias, or it
# will display "Unknown Account" otherwise.
#
# It supports the option `--profile=` that will select that profile
# for the aws-cli.
#

declare -A aws_accounts
aws_accounts["075687657552"]="fonemed-developers"
aws_accounts["017389651342"]="fonemed"
default_account="Unknown Account"

profile_option=""
while [[ $# -gt 0 ]]; do
    case "$1" in
        --profile)
            profile_option="--profile $2"
            shift 2
            ;;
        --profile=*)
            profile_option="--profile ${1#*=}"
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--profile a_profile_name] [--help]"
            echo "Display the effective AWS account ID.  Also display it's alias if we know it."
            echo "Useful for double checking that the effective account is the one you have in mind."
            echo "Options:"
            echo "  --profile PROFILE_NAME  Specify the AWS profile to use."
            echo "  --help | -h             Display this help message and exit."
            exit 0
            ;;
        *)
            echo "Usage: $0 [--profile a_profile_name|--help|-h]"
            exit 1
            ;;
    esac
done

caller_identity=$(aws $profile_option sts get-caller-identity)
if [[ $? -ne 0 ]]; then
    exit 1
fi
account=$(echo "$caller_identity" | jq --raw-output .Account)
account_name=${aws_accounts[$account]:-$default_account}
echo "$account_name ($account)"
