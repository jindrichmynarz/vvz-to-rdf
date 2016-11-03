#!/bin/bash

set -e

declare -a UPDATES=(
  # Reconciliations
  "reconcile_authority_kinds.ru"
  "reconcile_contract_kinds.ru"
  "reconcile_contracting_authority_activities.ru"
  "reconcile_procedure_types.ru"
  "reconcile_service_category.ru"

  # Linking
  "map_cpv_2003_to_cpv_2008.ru"
  "link_eu_projects.ru"

  # Cleaning
  "delete_cpv_2003_concepts.ru"
)

for update in "${UPDATES[@]}"; do
  cat $update
  echo ";"
done
