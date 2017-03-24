#!/bin/bash

set -e

declare -a UPDATES=(
  # Reconciliations
  "reconcile_authority_kinds.ru"
  "reconcile_contract_kinds.ru"
  "reconcile_contracting_authority_activities.ru"
  "reconcile_procedure_types.ru"
  "reconcile_service_category.ru"
  "reconcile_service_category_via_manual_mapping.ru"

  # Linking
  "map_cpv_2003_to_cpv_2008.ru"
  "unmapped_cpv_casted_as_cpv_2003.ru"
  "blank_nodes_to_hash_iris_concepts.ru" # Re-run blank nodes to IRIs for CPV 2003 proxy concepts
  "link_eu_projects.ru"

  # Cleaning
  "delete_cpv_2003_concepts.ru"

  # Resolve schema:Organization links
  # Iterate resolving links with clearing them.
  "resolve_same_as_links.ru"
  "clear_linkset_graph.ru"

  # Remove remnants of merged organizations
  "remove_invalid_ico_from_organizations_with_valid_ico.ru"
  "remove_organization_data_retrievable_from_ares.ru"
  "merge_ic.ru"
)

for update in "${UPDATES[@]}"; do
  cat $update
  echo ";"
done
