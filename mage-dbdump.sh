#!/bin/bash

IGNORE_TABLES=( dataflow_batch_export dataflow_batch_import log_customer log_quote log_summary log_summary_type log_url log_url_info log_visitor log_visitor_info log_visitor_online report_event index_event enterprise_logging_event_changes core_cache core_cache_tag core_session core_cache_tag )
IGNORE_TABLES_AGGRESSIVE=( report_compared_product_index report_viewed_product_index sales_flat_quote_address sales_flat_quote_shipping_rate enterprise_customer_sales_flat_quote enterprise_customer_sales_flat_quote_address sales_flat_quote )
IGNORE_TABLES_SUPER_AGGRESSIVE=( admin_assert admin_role admin_rule admin_user adminnotification_inbox amasty_methods_visibility api2_acl_attribute api2_acl_role api2_acl_rule api2_acl_user api_assert api_role api_rule api_session api_user attributesplash_group attributesplash_group_index attributesplash_group_store attributesplash_page attributesplash_page_index attributesplash_page_store captcha_log catalog_category_anc_categs_index_idx catalog_category_anc_categs_index_tmp catalog_category_anc_products_index_idx catalog_category_anc_products_index_tmp catalog_category_entity catalog_category_entity_datetime catalog_category_entity_decimal catalog_category_entity_int catalog_category_entity_text catalog_category_entity_varchar catalog_category_flat_store_1 catalog_category_flat_store_2 catalog_category_product catalog_category_product_index catalog_category_product_index_enbl_idx catalog_category_product_index_enbl_tmp catalog_category_product_index_idx catalog_category_product_index_tmp catalog_compare_item catalog_product_bundle_option catalog_product_bundle_option_value catalog_product_bundle_price_index catalog_product_bundle_selection catalog_product_bundle_selection_price catalog_product_bundle_stock_index catalog_product_enabled_index catalog_product_index_price_bundle_idx catalog_product_index_price_bundle_opt_idx catalog_product_index_price_bundle_opt_tmp catalog_product_index_price_bundle_sel_idx catalog_product_index_price_bundle_sel_tmp catalog_product_index_price_bundle_tmp catalog_product_index_price_cfg_opt_agr_idx catalog_product_index_price_cfg_opt_agr_tmp catalog_product_index_price_cfg_opt_idx catalog_product_index_price_cfg_opt_tmp catalog_product_index_price_downlod_idx catalog_product_index_price_downlod_tmp catalog_product_index_price_final_idx catalog_product_index_price_final_tmp catalog_product_index_price_opt_agr_idx catalog_product_index_price_opt_agr_tmp catalog_product_index_price_opt_idx catalog_product_index_price_opt_tmp catalog_product_index_price_tmp catalog_product_index_tier_price catalog_product_index_website catalog_product_website cataloginventory_stock cataloginventory_stock_item cataloginventory_stock_status cataloginventory_stock_status_idx cataloginventory_stock_status_tmp catalogrule catalogrule_affected_product catalogrule_customer_group catalogrule_group_website catalogrule_product catalogrule_product_price catalogrule_website catalogsearch_fulltext catalogsearch_query catalogsearch_result checkout_agreement checkout_agreement_store cms_block cms_block_store cms_page cms_page_store core_cache core_cache_option core_cache_tag core_email_queue core_email_queue_recipients core_email_template core_flag core_layout_link core_layout_update core_resource core_session core_store core_store_group core_translate core_url_rewrite core_variable core_variable_value core_website coupon_aggregated coupon_aggregated_order coupon_aggregated_updated cron_schedule customer_address_entity customer_address_entity_datetime customer_address_entity_decimal customer_address_entity_int customer_address_entity_text customer_address_entity_varchar customer_eav_attribute customer_eav_attribute_website customer_entity customer_entity_datetime customer_entity_decimal customer_entity_int customer_entity_text customer_entity_varchar customer_form_attribute customer_group dataflow_batch dataflow_batch_export dataflow_batch_import dataflow_import_data dataflow_profile dataflow_profile_history dataflow_session design_change directory_country directory_country_format directory_country_region directory_country_region_name directory_currency_rate downloadable_link downloadable_link_price downloadable_link_purchased downloadable_link_purchased_item downloadable_link_title downloadable_sample downloadable_sample_title ebizmarts_abandonedcart_abtesting ebizmarts_abandonedcart_popup ebizmarts_autoresponder_backtostock ebizmarts_autoresponder_backtostock_alert ebizmarts_autoresponder_review ebizmarts_autoresponder_unsubscribe ebizmarts_autoresponder_visited gift_message importexport_importdata index_event index_process index_process_event log_customer log_quote log_summary log_summary_type log_url log_url_info log_visitor log_visitor_info log_visitor_online magemonkey_api_debug magemonkey_async_orders magemonkey_async_subscribers magemonkey_bulksync_export magemonkey_bulksync_import magemonkey_ecommerce360 magemonkey_mails_sent newsletter_problem newsletter_queue newsletter_queue_link newsletter_queue_store_link newsletter_subscriber newsletter_template oauth_consumer oauth_nonce oauth_token paypal_cert paypal_payment_transaction paypal_settlement_report paypal_settlement_report_row paypalauth_customer persistent_session poll poll_answer poll_store poll_vote product_alert_price product_alert_stock rating rating_entity rating_option rating_option_vote rating_option_vote_aggregated rating_store rating_title report_compared_product_index report_event report_event_types report_viewed_product_aggregated_daily report_viewed_product_aggregated_monthly report_viewed_product_aggregated_yearly report_viewed_product_index review review_detail review_entity review_entity_summary review_status review_store sales_bestsellers_aggregated_daily sales_bestsellers_aggregated_monthly sales_bestsellers_aggregated_yearly sales_billing_agreement sales_billing_agreement_order sales_flat_creditmemo sales_flat_creditmemo_comment sales_flat_creditmemo_grid sales_flat_creditmemo_item sales_flat_invoice sales_flat_invoice_comment sales_flat_invoice_grid sales_flat_invoice_item sales_flat_order sales_flat_order_address sales_flat_order_grid sales_flat_order_item sales_flat_order_payment sales_flat_order_status_history sales_flat_quote sales_flat_quote_address sales_flat_quote_address_item sales_flat_quote_item sales_flat_quote_item_option sales_flat_quote_payment sales_flat_quote_shipping_rate sales_flat_shipment sales_flat_shipment_comment sales_flat_shipment_grid sales_flat_shipment_item sales_flat_shipment_track sales_invoiced_aggregated sales_invoiced_aggregated_order sales_order_aggregated_created sales_order_aggregated_updated sales_order_status sales_order_status_label sales_order_status_state sales_order_tax sales_order_tax_item sales_payment_transaction sales_recurring_profile sales_recurring_profile_order sales_refunded_aggregated sales_refunded_aggregated_order sales_shipping_aggregated sales_shipping_aggregated_order salesrule salesrule_coupon salesrule_coupon_usage salesrule_customer salesrule_customer_group salesrule_label salesrule_product_attribute salesrule_website sendfriend_log shipping_tablerate simplegoogleshopping sitemap sozo_about_page sozo_about_page_store sozo_banner_slide sozo_banner_slide_store sozo_blog_category sozo_blog_category_store sozo_blog_post sozo_blog_post_comment sozo_blog_post_comment_store sozo_blog_post_store sozo_faqs_category sozo_faqs_category_store sozo_faqs_faq sozo_faqs_faq_store sozo_features_eav_attribute sozo_features_feature sozo_features_feature_datetime sozo_features_feature_decimal sozo_features_feature_int sozo_features_feature_product sozo_features_feature_text sozo_features_feature_varchar sozo_homepage_box sozo_homepage_box_store splash_page splash_page_store tag tag_properties tag_relation tag_summary tax_calculation tax_calculation_rate tax_calculation_rate_title tax_calculation_rule tax_class tax_order_aggregated_created tax_order_aggregated_updated terapeak_salesanalytics_historical_data terapeak_salesanalytics_linked_channel terapeak_salesanalytics_user_credentials weee_discount weee_tax widget widget_instance widget_instance_page widget_instance_page_layout wishlist wishlist_item wishlist_item_option xmlconnect_application xmlconnect_config_data xmlconnect_history xmlconnect_images xmlconnect_notification_template xmlconnect_queue )
TRUNCATE_TABLES=( dataflow_batch_export dataflow_batch_import log_customer log_quote log_summary log_summary_type log_url log_url_info log_visitor log_visitor_info log_visitor_online report_viewed_product_index report_compared_product_index report_event index_event index_process_event )
CONFIG_FILE="./app/etc/local.xml"
DUMP_FILE="./var/db.sql"



function usage()
{
cat <<EOF
Usage:     $0 [OPTIONS]
Version:   1.03
Author:    www.sonassihosting.com
Download:  sys.sonassi.com/mage-dbdump.sh

This script is used to dump or restore Magento databases by reading
the local.xml file and parsing the DB credentials. It strips out
superfluous data (logs etc.) for smaller and quicker dumps. It also
optimises the dump by avoiding locks where possible.

Dumps to $DUMP_FILE(.gz)

If you have pigz installed, it will use that over gzip for parallel
compression/de-compression.

OPTIONS:
      -a             Advertise awesome hosting
      -d             Dump the database
      -r             Restore the databse
      -z             Use gzip compression (use with -d or -r)
      -e             Use extended inserts
      -h             Show help/usage
      -f             Full dump, do not exclude any tables
      -A             Aggressive dump, exclude (${IGNORE_TABLES_AGGRESSIVE[@]})
      -S             Super Aggresive dump, exclude (${IGNORE_TABLES_SUPER_AGGRESSIVE[@]})
      -B             Exclude additional custom tables (space separated, within "double quotes")
      -F             Do not ask questions and force all actions
      -i             Interactive, enter a mysql> prompt
      -c             Clean log and index tables

EOF
}

function error()
{
  echo -e "Error: $1"
  [[ ! "$2" == "noexit" ]] && exit 1
}

function getParam()
{
  # Used if CDATA fields are still present
  # RETVAL=$(grep -Eoh "<$1>(<!\[CDATA\[)*(.*)(\]\]>)*<\/$1>" $TMP_FILE | sed "s#<$1><!\[CDATA\[##g;s#\]\]><\/$1>##g")
  RETVAL=$(grep -Eoh "<$1>(<!\[CDATA\[)*(.*)(\]\]>)*<\/$1>" $TMP_FILE | sed "s#<$1>##g;s#<\/$1>##g")
  if [[ "$2" == "sanitise" ]]; then
    RETVAL=$(echo "$RETVAL" | sed 's/"/\\\"/g')
  fi
  echo -e "$RETVAL"
}

function compress()
{
  while read DATA; do
    [[ ! "$OPT_z" == "" ]] && (echo "$DATA" | $GZIP_CMD -) || echo "$DATA"
  done
}

function mysqldumpit()
{

  if [[ "$OPT_f" == "" ]]; then
    [[ ! "$OPT_S" == "" ]] && IGNORE_TABLES=( ${IGNORE_TABLES_SUPER_AGGRESSIVE[@]} )
    [[ ! "$OPT_A" == "" ]] && IGNORE_TABLES=( ${IGNORE_TABLES[@]} ${IGNORE_TABLES_AGGRESSIVE[@]} )
    [[ ! "$OPT_B" == "" ]] && IGNORE_TABLES=( ${IGNORE_TABLES[@]} $OPT_B )
    for TABLE in "${IGNORE_TABLES[@]}"; do
      IGNORE_STRING="$IGNORE_STRING --ignore-table=$DBNAME.$TABLE_PREFIX$TABLE"
    done
  fi

  # We use --single-transaction in favour of --lock-tables=false , its slower, but less potential for unreliable dumps
  echo "SET SESSION sql_mode='NO_AUTO_VALUE_ON_ZERO';"
  ( mysqldump -p"$DBPASS" $MYSQL_ARGS --no-data --routines --triggers --single-transaction; \
      mysqldump -p"$DBPASS" $MYSQL_ARGS $IGNORE_STRING --no-create-db --single-transaction ) | sed 's/DEFINER=[^*]*\*/\*/g'
}

function question()
{
  [[ ! "$OPT_F" == "" ]] && return 0
  echo -n "$1 [y/N]: "
  read CONFIRM
  [[ "$CONFIRM" == "y" ]] || [[ "$CONFIRM" == "Y" ]] && return 0
  return 1
}

function message()
{
  STRIP=$(for i in {1..38}; do echo -n "#"; done)
  echo -e "$STRIP\n$1\n$STRIP"
}

function banner()
{
cat <<EOT
######################################

                              (_)
 ___  ___  _ __   __ _ ___ ___ _
/ __|/ _ \| '_ \ / _' / __/ __| |
\__ \ (_) | | | | (_| \__ \__ \ |
|___/\___/|_| |_|\__'_|___/___/_|

For truly optimised Magento hosting
Use http://www.sonassihosting.com ...

#####################################

EOT
}

[ ! -f "$CONFIG_FILE" ] && error "$CONFIG_FILE does not exist"

while getopts "B:ASdrzehfFaic" OPTION; do
  case $OPTION in
    a)
      banner
      exit 0
      ;;
    h)
      usage
      exit 0
      ;;
    :)
      error "Error: -$OPTION requires an argument" noexit
      exit 1
      ;;
    \?)
      error "Error: Unknown option -$OPTION" noexit
      exit 1
      ;;
    *)
      [[ "$OPTARG" == "" ]] && OPTARG='"-'$OPTION' 1"'
      OPTION="OPT_$OPTION"
      eval ${OPTION}=$OPTARG
      ;;
  esac
done

[[ "$OPT_c$OPT_i$OPT_d$OPT_r$OPT_A$OPT_S" == "" ]] && usage && exit 1

which mktemp >/dev/null 2>&1
[ $? -eq 0 ] && TMP_FILE=$(mktemp ./var/local.xml.XXXXX) || TMP_FILE="./var/.tmp.local.xml"
sed -ne '/default_setup/,/\/default_setup/p' $CONFIG_FILE > $TMP_FILE

which pigz >/dev/null 2>&1
[ $? -eq 0 ] && GZIP_CMD="pigz" || GZIP_CMD="gzip"

IGNORE_STRING=""
DBHOST=$(getParam "host")
DBUSER=$(getParam "username")
DBPASS=$(getParam "password" "sanitise" )
DBNAME=$(getParam "dbname")
TABLE_PREFIX=$(getParam "table_prefix")
[ -f $TMP_FILE ] && rm $TMP_FILE
[[ ! "$OPT_z" == "" ]] && DUMP_FILE="$DUMP_FILE"".gz"

MYSQL_ARGS="-f -h $DBHOST -u $DBUSER $DBNAME"
[[ ! "$OPT_e" == "" ]] && MYSQL_ARGS="$MYSQL_ARGS --extended-insert=FALSE --complete-insert=TRUE"

if [[ ! "$OPT_r" == "" ]]; then

  [ ! -f "$DUMP_FILE" ] && error "SQL file does not exist"
  question "Are you sure you want to restore $DUMP_FILE to $DBNAME?"
  if [ $? -eq 0 ]; then
    [[ ! "$OPT_z" == "" ]] && $GZIP_CMD -d <$DUMP_FILE | mysql $MYSQL_ARGS -p"$DBPASS" || mysql $MYSQL_ARGS -p"$DBPASS" <$DUMP_FILE
    message "MYSQL IMPORT COMPLETE"
    banner
  fi
  exit 0

elif [[ ! "$OPT_c" == "" ]]; then

  for TABLE in ${TRUNCATE_TABLES[@]}; do
    echo "Cleaning $TABLE ..."
    mysql $MYSQL_ARGS -p"$DBPASS" -e "TRUNCATE ${TABLE_PREFIX}$TABLE"
  done

elif [[ ! "$OPT_i" == "" ]]; then

  mysql $MYSQL_ARGS -p"$DBPASS"

elif [[ ! "$OPT_d$OPT_A$OPT_B$OPT_S" == "" ]]; then

  [[ ! "$OPT_z" == "" ]] && mysqldumpit | $GZIP_CMD > $DUMP_FILE || mysqldumpit > $DUMP_FILE
  message "MYSQL DUMP COMPLETE"
  exit 0

fi
