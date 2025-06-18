module emotionexplorer::emotion_core;


public struct EmotionalRecord has key, store {
    id: UID,
    creator_address: address,
    post_id: vector<u8>,
    comment_id: vector<u8>,
    sentiment: u8,
    timestamp: u64,
    content_hash: vector<u8>
}

public fun record_sentiment(
    ctx: &mut tx_context::TxContext,
    creator_address: address,
    post_id: vector<u8>,
    comment_id: vector<u8>,
    sentiment: u8,
    content_hash: vector<u8>
) {
    // create record
    let record = EmotionalRecord {
        id: object::new(ctx),
        creator_address,
        post_id,
        comment_id,
        sentiment,
        timestamp: tx_context::epoch_timestamp_ms(ctx),
        content_hash
    };

    transfer::public_transfer(record, creator_address)
}